// Follow this setup guide to integrate the Deno language server with your editor:
// https://deno.land/manual/getting_started/setup_your_environment
// This enables autocomplete, go to definition, etc.

// Setup type definitions for built-in Supabase Runtime APIs
import "jsr:@supabase/functions-js/edge-runtime.d.ts";
import { createClient } from "npm:@supabase/supabase-js@2";
import { JWT } from "npm:google-auth-library@9.15.1";

interface Listing {
  uid: string;
  host: string;
  status: string;
}

interface WebhookPayload {
  type: "UPDATE";
  table: string;
  record: Listing;
  old_record: Listing;
  schema: "public";
}

const supabase = createClient(
  Deno.env.get("SUPABASE_URL")!,
  Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!,
);

Deno.serve(async (req) => {
  const payload: WebhookPayload = await req.json();

  const { data: hostData } = await supabase
    .from("users")
    .select("fcm_token")
    .eq("user_id", payload.record.host)
    .single();

  if (hostData?.fcm_token == null) {
    return new Response("No FCM Token", {
      status: 200,
      headers: { "Content-Type": "application/json" },
    });
  }

  const { default: serviceAccount } = await import("../service-account.json", {
    with: { type: "json" },
  });

  const accessToken = await getAccessToken({
    clientEmail: serviceAccount.client_email,
    privateKey: serviceAccount.private_key,
  });

  const res = await fetch(
    `https://fcm.googleapis.com/v1/projects/${serviceAccount.project_id}/messages:send`,
    {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${accessToken}`,
      },
      body: JSON.stringify({
        message: {
          token: hostData?.fcm_token,

          notification: {
            title: `Your bhandara has been ${payload.record.status}`,
            body: "Thanks for choosing Prasad to host your bhandara!",
          },
        },
      }),
    },
  );

  const resData = await res.json();

  if (res.status < 200 || 299 < res.status) {
    throw resData;
  }

  return new Response(JSON.stringify(resData), {
    headers: { "Content-Type": "application/json" },
  });
});

const getAccessToken = ({
  clientEmail,
  privateKey,
}: {
  clientEmail: string;
  privateKey: string;
}): Promise<string> => {
  return new Promise((resolve, reject) => {
    const jwtClient = new JWT({
      email: clientEmail,
      key: privateKey,
      scopes: ["https://www.googleapis.com/auth/firebase.messaging"],
    });
    jwtClient.authorize((err, tokens) => {
      if (err) {
        reject(err);
        return;
      }
      resolve(tokens!.access_token!);
    });
  });
};

/* To invoke locally:

  1. Run `supabase start` (see: https://supabase.com/docs/reference/cli/supabase-start)
  2. Make an HTTP request:

  curl -i --location --request POST 'http://127.0.0.1:54321/functions/v1/status_change_notification' \
    --header 'Authorization: Bearer eyJhbGciOiJFUzI1NiIsImtpZCI6ImI4MTI2OWYxLTIxZDgtNGYyZS1iNzE5LWMyMjQwYTg0MGQ5MCIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjIwODU0MTI4Mzl9.ewFc8AqQwE4PR-BNDycwkQU9D_MbUVeyHuuVGpxiTTTDe37uIPBj4I97Sd8t6xlnmXKDAKMC_rPm--TofoNJrA' \
    --header 'Content-Type: application/json' \
    --data '{"name":"Functions"}'

*/
