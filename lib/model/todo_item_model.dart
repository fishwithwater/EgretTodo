class TodoItemModel{
  ///主键
  int id;
  /// 主题
  String title;
  /// 副主题
  String subTitle;
  ///是否完成
  bool finished;
  ///截止时间
  DateTime deadline;
  ///优先级
  int priority;

  TodoItemModel(this.title,{this.subTitle, this.finished=false, this.deadline});

  TodoItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subTitle = json['subTitle'];
    deadline = json['deadline'];
    priority = json['priority'];
    finished = json['finished'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['subTitle'] = this.subTitle;
    data['deadline'] = this.deadline;
    data['priority'] = this.priority;
    data['finished'] = this.finished;
    return data;
  }
}