class GameEvent {
  String? eventId;
  String? eventName;
  String? image;
  int? duration;
  List<SubEvents>? subEvents;
  List<Rewards>? rewards;
  String? uuid;

  GameEvent(
      {this.eventId,
        this.eventName,
        this.image,
        this.duration,
        this.subEvents,
        this.rewards});

  GameEvent.fromJson(Map<String, dynamic> json) {
    eventId = json['event_id'];
    eventName = json['event_name'];
    image = json['image'];
    duration = json['duration'];
    if (json['sub_events'] != null) {
      subEvents = <SubEvents>[];
      json['sub_events'].forEach((v) {
        subEvents!.add(new SubEvents.fromJson(v));
      });
    }
    if (json['rewards'] != null) {
      rewards = <Rewards>[];
      json['rewards'].forEach((v) {
        rewards!.add(new Rewards.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['event_id'] = this.eventId;
    data['event_name'] = this.eventName;
    data['image'] = this.image;
    data['duration'] = this.duration;
    if (this.subEvents != null) {
      data['sub_events'] = this.subEvents!.map((v) => v.toJson()).toList();
    }
    if (this.rewards != null) {
      data['rewards'] = this.rewards!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubEvents {
  String? subEventId;
  String? subEventName;
  String? description;
  String? emojiSummary;
  double? rate;
  List<Effects>? effects;
  List<Rewards>? rewards;

  SubEvents(
      {this.subEventId,
        this.subEventName,
        this.description,
        this.emojiSummary,
        this.rate,
        this.effects,
        this.rewards});

  SubEvents.fromJson(Map<String, dynamic> json) {
    subEventId = json['sub_event_id'].toString();
    subEventName = json['sub_event_name'];
    description = json['description'];
    emojiSummary = json['emoji_summary'];
    rate = double.tryParse(json['rate'].toString());
    if (json['effects'] != null) {
      effects = <Effects>[];
      json['effects'].forEach((v) {
        effects!.add(new Effects.fromJson(v));
      });
    }
    if (json['rewards'] != null) {
      rewards = <Rewards>[];
      json['rewards'].forEach((v) {
        rewards!.add(new Rewards.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sub_event_id'] = this.subEventId;
    data['sub_event_name'] = this.subEventName;
    data['description'] = this.description;
    data['emoji_summary'] = this.emojiSummary;
    data['rate'] = this.rate;
    if (this.effects != null) {
      data['effects'] = this.effects!.map((v) => v.toJson()).toList();
    }
    if (this.rewards != null) {
      data['rewards'] = this.rewards!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Effects {
  String? item;
  int? effect;

  Effects({this.item, this.effect});

  Effects.fromJson(Map<String, dynamic> json) {
    item = json['item'];
    effect = json['effect'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item'] = this.item;
    data['effect'] = this.effect;
    return data;
  }
}

class Rewards {
  String? eventId;
  String? eventName;
  List<Conditions>? conditions;

  Rewards({this.eventId, this.eventName, this.conditions});

  Rewards.fromJson(Map<String, dynamic> json) {
    eventId = json['event_id'].toString();
    eventName = json['event_name'];
    if (json['conditions'] != null) {
      conditions = <Conditions>[];
      json['conditions'].forEach((v) {
        conditions!.add(new Conditions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['event_id'] = this.eventId;
    data['event_name'] = this.eventName;
    if (this.conditions != null) {
      data['conditions'] = this.conditions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Conditions {
  String? eventId;
  int? times;

  Conditions({this.eventId, this.times});

  Conditions.fromJson(Map<String, dynamic> json) {
    eventId = json['event_id'].toString();
    times = json['times'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['event_id'] = this.eventId;
    data['times'] = this.times;
    return data;
  }
}