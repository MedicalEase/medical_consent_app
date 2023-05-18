/// A dataclass for a procedure (e.g. a surgery)

class SummaryData {
  @override
  String toString() {
    return 'Summary{ throat: $throatSpray}';
  }
  // yes | no | '<ANYTHING ELSE>'
  final int id = 0;
  String throatSpray = 'yes';
  String sedation = 'yes';
  String beingCollected = 'yes';
  String beingAccompanied = 'yes';
  String knowsRisks = 'yes';
  String willProceed = 'yes';
}
