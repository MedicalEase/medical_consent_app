/// A dataclass for a procedure (e.g. a surgery)

class SummaryData {

  @override
  String toString() {
    return 'Summary{ throat: $throatSpray}';
  }

  final int id = 0;
  final String throatSpray = 'yes';
  final String sedation = 'yes';
  final String beingCollected = 'yes';
  final String beingAccompianied = 'yes';
  final String knowsRisks = 'yes';
  final String willProceed = 'yes';
}
