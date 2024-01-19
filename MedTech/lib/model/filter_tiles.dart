class StatusTile {
  final String title;
  final String status;

  StatusTile({
    required this.title,
    required this.status,
  });
}

final List<StatusTile> donationList = [
  StatusTile(title: 'heart', status: 'All'),
  StatusTile(title: 'liver', status: 'pending'),
  StatusTile(title: 'lung', status: 'completed'),
  StatusTile(title: 'eyes', status: 'All'),
  StatusTile(title: 'kidney', status: 'pending'),
  StatusTile(title: 'stomach', status: 'All'),
  StatusTile(title: 'pancreas', status: 'completed'),
  StatusTile(title: 'toungue', status: 'All'),
  StatusTile(title: 'nose', status: 'pending'),
  StatusTile(title: 'hair', status: 'All'),
  StatusTile(title: 'nails', status: 'completed'),
  StatusTile(title: 'feet', status: 'All'),
  StatusTile(title: 'toes', status: 'pending'),
  StatusTile(title: 'legpiece', status: 'All'),
  StatusTile(title: 'bladder', status: 'All'),
  StatusTile(title: 'teeth', status: 'pending'),
];
