String sendStructure(int index, int total, DateTime initialTime, String data) {
  var res = {
    "index": index,
    "total": total,
    "time": initialTime.millisecondsSinceEpoch,
    "data": data
  };
  return res.toString();
}
