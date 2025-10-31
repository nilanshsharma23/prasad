enum Status {
  unverified("unverified", "Unverified"),
  accepted("accepted", "Accepted"),
  rejected("rejected", "Rejected");

  const Status(this.value, this.label);
  final String value;
  final String label;

  static Status fromString(String value) {
    return Status.values.firstWhere((element) => element.value == value);
  }
}
