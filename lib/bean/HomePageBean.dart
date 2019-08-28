import 'dart:convert' show json;

class HomePageBean {
  Data data;

  HomePageBean.fromParams({this.data});

  factory HomePageBean(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new HomePageBean.fromJson(json.decode(jsonStr))
          : new HomePageBean.fromJson(jsonStr);

  HomePageBean.fromJson(jsonRes) {
    data = jsonRes['data'] == null ? null : new Data.fromJson(jsonRes['data']);
  }

  @override
  String toString() {
    return '{"data": $data}';
  }
}

class Data {
  AbdoMen abdomen;

  Data.fromParams({this.abdomen});

  Data.fromJson(jsonRes) {
    abdomen = jsonRes['abdomen'] == null
        ? null
        : new AbdoMen.fromJson(jsonRes['abdomen']);
  }

  @override
  String toString() {
    return '{"abdomen": $abdomen}';
  }
}

class AbdoMen {
  List<DeliVery> delivery;
  List<Slide> slide;
  KMusic K_MUSIC;
  BookWorm bookworm;
  Delicious delicious;
  Enjoy enjoy;
  Major major;
  Vip vip;
  WholeSale wholesale;

  AbdoMen.fromParams(
      {this.delivery,
      this.slide,
      this.K_MUSIC,
      this.bookworm,
      this.delicious,
      this.enjoy,
      this.major,
      this.vip,
      this.wholesale});

  AbdoMen.fromJson(jsonRes) {
    delivery = jsonRes['delivery'] == null ? null : [];

    for (var deliveryItem in delivery == null ? [] : jsonRes['delivery']) {
      delivery.add(
          deliveryItem == null ? null : new DeliVery.fromJson(deliveryItem));
    }

    slide = jsonRes['slide'] == null ? null : [];

    for (var slideItem in slide == null ? [] : jsonRes['slide']) {
      slide.add(slideItem == null ? null : new Slide.fromJson(slideItem));
    }

    K_MUSIC = jsonRes['K_MUSIC'] == null
        ? null
        : new KMusic.fromJson(jsonRes['K_MUSIC']);
    bookworm = jsonRes['bookworm'] == null
        ? null
        : new BookWorm.fromJson(jsonRes['bookworm']);
    delicious = jsonRes['delicious'] == null
        ? null
        : new Delicious.fromJson(jsonRes['delicious']);
    enjoy =
        jsonRes['enjoy'] == null ? null : new Enjoy.fromJson(jsonRes['enjoy']);
    major =
        jsonRes['major'] == null ? null : new Major.fromJson(jsonRes['major']);
    vip = jsonRes['vip'] == null ? null : new Vip.fromJson(jsonRes['vip']);
    wholesale = jsonRes['wholesale'] == null
        ? null
        : new WholeSale.fromJson(jsonRes['wholesale']);
  }

  @override
  String toString() {
    return '{"delivery": $delivery,"slide": $slide,"KMUSIC": $K_MUSIC,"bookworm": $bookworm,"delicious": $delicious,"enjoy": $enjoy,"major": $major,"vip": $vip,"wholesale": $wholesale}';
  }
}

class WholeSale {
  String wholesalebaseimg;
  List<WholeSaleImgs> wholesaleimgs;

  WholeSale.fromParams({this.wholesalebaseimg, this.wholesaleimgs});

  WholeSale.fromJson(jsonRes) {
    wholesalebaseimg = jsonRes['wholesalebaseimg'];
    wholesaleimgs = jsonRes['wholesaleimgs'] == null ? null : [];

    for (var wholesaleimgsItem
        in wholesaleimgs == null ? [] : jsonRes['wholesaleimgs']) {
      wholesaleimgs.add(wholesaleimgsItem == null
          ? null
          : new WholeSaleImgs.fromJson(wholesaleimgsItem));
    }
  }

  @override
  String toString() {
    return '{"wholesalebaseimg": ${wholesalebaseimg != null ? '${json.encode(wholesalebaseimg)}' : 'null'},"wholesaleimgs": $wholesaleimgs}';
  }
}

class WholeSaleImgs {
  int id;
  String name;
  String url;

  WholeSaleImgs.fromParams({this.id, this.name, this.url});

  WholeSaleImgs.fromJson(jsonRes) {
    id = jsonRes['id'];
    name = jsonRes['name'];
    url = jsonRes['url'];
  }

  @override
  String toString() {
    return '{"id": $id,"name": ${name != null ? '${json.encode(name)}' : 'null'},"url": ${url != null ? '${json.encode(url)}' : 'null'}}';
  }
}

class Vip {
  String vipbaseimg;
  List<VipImgs> vipimgs;

  Vip.fromParams({this.vipbaseimg, this.vipimgs});

  Vip.fromJson(jsonRes) {
    vipbaseimg = jsonRes['vipbaseimg'];
    vipimgs = jsonRes['vipimgs'] == null ? null : [];

    for (var vipimgsItem in vipimgs == null ? [] : jsonRes['vipimgs']) {
      vipimgs
          .add(vipimgsItem == null ? null : new VipImgs.fromJson(vipimgsItem));
    }
  }

  @override
  String toString() {
    return '{"vipbaseimg": ${vipbaseimg != null ? '${json.encode(vipbaseimg)}' : 'null'},"vipimgs": $vipimgs}';
  }
}

class VipImgs {
  int id;
  String name;
  String url;

  VipImgs.fromParams({this.id, this.name, this.url});

  VipImgs.fromJson(jsonRes) {
    id = jsonRes['id'];
    name = jsonRes['name'];
    url = jsonRes['url'];
  }

  @override
  String toString() {
    return '{"id": $id,"name": ${name != null ? '${json.encode(name)}' : 'null'},"url": ${url != null ? '${json.encode(url)}' : 'null'}}';
  }
}

class Major {
  String majorbaseimg;
  List<MajorImgs> majorimgs;

  Major.fromParams({this.majorbaseimg, this.majorimgs});

  Major.fromJson(jsonRes) {
    majorbaseimg = jsonRes['majorbaseimg'];
    majorimgs = jsonRes['majorimgs'] == null ? null : [];

    for (var majorimgsItem in majorimgs == null ? [] : jsonRes['majorimgs']) {
      majorimgs.add(
          majorimgsItem == null ? null : new MajorImgs.fromJson(majorimgsItem));
    }
  }

  @override
  String toString() {
    return '{"majorbaseimg": ${majorbaseimg != null ? '${json.encode(majorbaseimg)}' : 'null'},"majorimgs": $majorimgs}';
  }
}

class MajorImgs {
  int id;
  String name;
  String url;

  MajorImgs.fromParams({this.id, this.name, this.url});

  MajorImgs.fromJson(jsonRes) {
    id = jsonRes['id'];
    name = jsonRes['name'];
    url = jsonRes['url'];
  }

  @override
  String toString() {
    return '{"id": $id,"name": ${name != null ? '${json.encode(name)}' : 'null'},"url": ${url != null ? '${json.encode(url)}' : 'null'}}';
  }
}

class Enjoy {
  String enjoybaseimg;
  List<EnjoyImgs> enjoyimgs;

  Enjoy.fromParams({this.enjoybaseimg, this.enjoyimgs});

  Enjoy.fromJson(jsonRes) {
    enjoybaseimg = jsonRes['enjoybaseimg'];
    enjoyimgs = jsonRes['enjoyimgs'] == null ? null : [];

    for (var enjoyimgsItem in enjoyimgs == null ? [] : jsonRes['enjoyimgs']) {
      enjoyimgs.add(
          enjoyimgsItem == null ? null : new EnjoyImgs.fromJson(enjoyimgsItem));
    }
  }

  @override
  String toString() {
    return '{"enjoybaseimg": ${enjoybaseimg != null ? '${json.encode(enjoybaseimg)}' : 'null'},"enjoyimgs": $enjoyimgs}';
  }
}

class EnjoyImgs {
  int id;
  String name;
  String url;

  EnjoyImgs.fromParams({this.id, this.name, this.url});

  EnjoyImgs.fromJson(jsonRes) {
    id = jsonRes['id'];
    name = jsonRes['name'];
    url = jsonRes['url'];
  }

  @override
  String toString() {
    return '{"id": $id,"name": ${name != null ? '${json.encode(name)}' : 'null'},"url": ${url != null ? '${json.encode(url)}' : 'null'}}';
  }
}

class Delicious {
  String deliciousbaseimg;
  List<DeliciousImgs> deliciousimgs;

  Delicious.fromParams({this.deliciousbaseimg, this.deliciousimgs});

  Delicious.fromJson(jsonRes) {
    deliciousbaseimg = jsonRes['deliciousbaseimg'];
    deliciousimgs = jsonRes['deliciousimgs'] == null ? null : [];

    for (var deliciousimgsItem
        in deliciousimgs == null ? [] : jsonRes['deliciousimgs']) {
      deliciousimgs.add(deliciousimgsItem == null
          ? null
          : new DeliciousImgs.fromJson(deliciousimgsItem));
    }
  }

  @override
  String toString() {
    return '{"deliciousbaseimg": ${deliciousbaseimg != null ? '${json.encode(deliciousbaseimg)}' : 'null'},"deliciousimgs": $deliciousimgs}';
  }
}

class DeliciousImgs {
  int id;
  String name;
  String url;

  DeliciousImgs.fromParams({this.id, this.name, this.url});

  DeliciousImgs.fromJson(jsonRes) {
    id = jsonRes['id'];
    name = jsonRes['name'];
    url = jsonRes['url'];
  }

  @override
  String toString() {
    return '{"id": $id,"name": ${name != null ? '${json.encode(name)}' : 'null'},"url": ${url != null ? '${json.encode(url)}' : 'null'}}';
  }
}

class BookWorm {
  String bookwormbaseimg;
  List<BookwormImgs> bookwormimgs;

  BookWorm.fromParams({this.bookwormbaseimg, this.bookwormimgs});

  BookWorm.fromJson(jsonRes) {
    bookwormbaseimg = jsonRes['bookwormbaseimg'];
    bookwormimgs = jsonRes['bookwormimgs'] == null ? null : [];

    for (var bookwormimgsItem
        in bookwormimgs == null ? [] : jsonRes['bookwormimgs']) {
      bookwormimgs.add(bookwormimgsItem == null
          ? null
          : new BookwormImgs.fromJson(bookwormimgsItem));
    }
  }

  @override
  String toString() {
    return '{"bookwormbaseimg": ${bookwormbaseimg != null ? '${json.encode(bookwormbaseimg)}' : 'null'},"bookwormimgs": $bookwormimgs}';
  }
}

class BookwormImgs {
  int id;
  String name;
  String url;

  BookwormImgs.fromParams({this.id, this.name, this.url});

  BookwormImgs.fromJson(jsonRes) {
    id = jsonRes['id'];
    name = jsonRes['name'];
    url = jsonRes['url'];
  }

  @override
  String toString() {
    return '{"id": $id,"name": ${name != null ? '${json.encode(name)}' : 'null'},"url": ${url != null ? '${json.encode(url)}' : 'null'}}';
  }
}

class KMusic {
  String K_MUSICBaseImg;
  List<KMusicImgs> K_MUSICImgs;

  KMusic.fromParams({this.K_MUSICBaseImg, this.K_MUSICImgs});

  KMusic.fromJson(jsonRes) {
    K_MUSICBaseImg = jsonRes['K_MUSICBaseImg'];
    K_MUSICImgs = jsonRes['K_MUSICImgs'] == null ? null : [];

    for (var KMUSICImgsItem
        in K_MUSICImgs == null ? [] : jsonRes['K_MUSICImgs']) {
      K_MUSICImgs.add(KMUSICImgsItem == null
          ? null
          : new KMusicImgs.fromJson(KMUSICImgsItem));
    }
  }

  @override
  String toString() {
    return '{"K_MUSICBaseImg": ${K_MUSICBaseImg != null ? '${json.encode(K_MUSICBaseImg)}' : 'null'},"K_MUSICImgs": $K_MUSICImgs}';
  }
}

class KMusicImgs {
  int id;
  String name;
  String url;

  KMusicImgs.fromParams({this.id, this.name, this.url});

  KMusicImgs.fromJson(jsonRes) {
    id = jsonRes['id'];
    name = jsonRes['name'];
    url = jsonRes['url'];
  }

  @override
  String toString() {
    return '{"id": $id,"name": ${name != null ? '${json.encode(name)}' : 'null'},"url": ${url != null ? '${json.encode(url)}' : 'null'}}';
  }
}

class Slide {
  int id;
  String name;
  String url;

  Slide.fromParams({this.id, this.name, this.url});

  Slide.fromJson(jsonRes) {
    id = jsonRes['id'];
    name = jsonRes['name'];
    url = jsonRes['url'];
  }

  @override
  String toString() {
    return '{"id": $id,"name": ${name != null ? '${json.encode(name)}' : 'null'},"url": ${url != null ? '${json.encode(url)}' : 'null'}}';
  }
}

class DeliVery {
  int id;
  String name;
  String url;

  DeliVery.fromParams({this.id, this.name, this.url});

  DeliVery.fromJson(jsonRes) {
    id = jsonRes['id'];
    name = jsonRes['name'];
    url = jsonRes['url'];
  }

  @override
  String toString() {
    return '{"id": $id,"name": ${name != null ? '${json.encode(name)}' : 'null'},"url": ${url != null ? '${json.encode(url)}' : 'null'}}';
  }
}
