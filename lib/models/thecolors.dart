// To parse this JSON data, do
//
//     final theColor = theColorFromJson(jsonString);

import 'dart:convert';

TheColor theColorFromJson(String str) => TheColor.fromJson(json.decode(str));

String theColorToJson(TheColor data) => json.encode(data.toJson());

class TheColor {
  TheColor({
    this.hex,
    this.rgb,
    this.hsl,
    this.hsv,
    this.name,
    this.cmyk,
    this.xyz,
    this.image,
    this.contrast,
    this.links,
    this.embedded,
  });

  Hex? hex;
  Rgb? rgb;
  Hsl? hsl;
  Hsv? hsv;
  Name? name;
  Cmyk? cmyk;
  Xyz? xyz;
  Image? image;
  Contrast? contrast;
  Links? links;
  Embedded? embedded;

  factory TheColor.fromJson(Map<String, dynamic> json) => TheColor(
        hex: Hex.fromJson(json["hex"]),
        rgb: Rgb.fromJson(json["rgb"]),
        hsl: Hsl.fromJson(json["hsl"]),
        hsv: Hsv.fromJson(json["hsv"]),
        name: Name.fromJson(json["name"]),
        cmyk: Cmyk.fromJson(json["cmyk"]),
        xyz: Xyz.fromJson(json["XYZ"]),
        image: Image.fromJson(json["image"]),
        contrast: Contrast.fromJson(json["contrast"]),
        links: Links.fromJson(json["_links"]),
        embedded: Embedded.fromJson(json["_embedded"]),
      );

  Map<String, dynamic> toJson() => {
        "hex": hex!.toJson(),
        "rgb": rgb!.toJson(),
        "hsl": hsl!.toJson(),
        "hsv": hsv!.toJson(),
        "name": name!.toJson(),
        "cmyk": cmyk!.toJson(),
        "XYZ": xyz!.toJson(),
        "image": image!.toJson(),
        "contrast": contrast!.toJson(),
        "_links": links!.toJson(),
        "_embedded": embedded!.toJson(),
      };
}

class Cmyk {
  Cmyk({
    this.fraction,
    this.value,
    this.c,
    this.m,
    this.y,
    this.k,
  });

  CmykFraction? fraction;
  String? value;
  dynamic? c;
  dynamic? m;
  dynamic? y;
  int? k;

  factory Cmyk.fromJson(Map<String, dynamic> json) => Cmyk(
        fraction: CmykFraction.fromJson(json["fraction"]),
        value: json["value"],
        c: json["c"],
        m: json["m"],
        y: json["y"],
        k: json["k"],
      );

  Map<String, dynamic> toJson() => {
        "fraction": fraction!.toJson(),
        "value": value,
        "c": c,
        "m": m,
        "y": y,
        "k": k,
      };
}

class CmykFraction {
  CmykFraction({
    this.c,
    this.m,
    this.y,
    this.k,
  });

  dynamic? c;
  dynamic? m;
  dynamic? y;
  int? k;

  factory CmykFraction.fromJson(Map<String, dynamic> json) => CmykFraction(
        c: json["c"],
        m: json["m"],
        y: json["y"],
        k: json["k"],
      );

  Map<String, dynamic> toJson() => {
        "c": c,
        "m": m,
        "y": y,
        "k": k,
      };
}

class Contrast {
  Contrast({
    this.value,
  });

  String? value;

  factory Contrast.fromJson(Map<String, dynamic> json) => Contrast(
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
      };
}

class Embedded {
  Embedded();

  factory Embedded.fromJson(Map<String, dynamic> json) => Embedded();

  Map<String, dynamic> toJson() => {};
}

class Hex {
  Hex({
    this.value,
    this.clean,
  });

  String? value;
  String? clean;

  factory Hex.fromJson(Map<String, dynamic> json) => Hex(
        value: json["value"],
        clean: json["clean"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "clean": clean,
      };
}

class Hsl {
  Hsl({
    this.fraction,
    this.h,
    this.s,
    this.l,
    this.value,
  });

  HslFraction? fraction;
  int? h;
  int? s;
  int? l;
  String? value;

  factory Hsl.fromJson(Map<String, dynamic> json) => Hsl(
        fraction: HslFraction.fromJson(json["fraction"]),
        h: json["h"],
        s: json["s"],
        l: json["l"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "fraction": fraction!.toJson(),
        "h": h,
        "s": s,
        "l": l,
        "value": value,
      };
}

class HslFraction {
  HslFraction({
    this.h,
    this.s,
    this.l,
  });

  int? h;
  int? s;
  int? l;

  factory HslFraction.fromJson(Map<String, dynamic> json) => HslFraction(
        h: json["h"],
        s: json["s"],
        l: json["l"],
      );

  Map<String, dynamic> toJson() => {
        "h": h,
        "s": s,
        "l": l,
      };
}

class Hsv {
  Hsv({
    this.fraction,
    this.value,
    this.h,
    this.s,
    this.v,
  });

  HsvFraction? fraction;
  String? value;
  int? h;
  int? s;
  int? v;

  factory Hsv.fromJson(Map<String, dynamic> json) => Hsv(
        fraction: HsvFraction.fromJson(json["fraction"]),
        value: json["value"],
        h: json["h"],
        s: json["s"],
        v: json["v"],
      );

  Map<String, dynamic> toJson() => {
        "fraction": fraction!.toJson(),
        "value": value,
        "h": h,
        "s": s,
        "v": v,
      };
}

class HsvFraction {
  HsvFraction({
    this.h,
    this.s,
    this.v,
  });

  int? h;
  int? s;
  int? v;

  factory HsvFraction.fromJson(Map<String, dynamic> json) => HsvFraction(
        h: json["h"],
        s: json["s"],
        v: json["v"],
      );

  Map<String, dynamic> toJson() => {
        "h": h,
        "s": s,
        "v": v,
      };
}

class Image {
  Image({
    this.bare,
    this.named,
  });

  String? bare;
  String? named;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        bare: json["bare"],
        named: json["named"],
      );

  Map<String, dynamic> toJson() => {
        "bare": bare,
        "named": named,
      };
}

class Links {
  Links({
    this.self,
  });

  Self? self;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        self: Self.fromJson(json["self"]),
      );

  Map<String, dynamic> toJson() => {
        "self": self!.toJson(),
      };
}

class Self {
  Self({
    this.href,
  });

  String? href;

  factory Self.fromJson(Map<String, dynamic> json) => Self(
        href: json["href"],
      );

  Map<String, dynamic> toJson() => {
        "href": href,
      };
}

class Name {
  Name({
    this.value,
    this.closestNamedHex,
    this.exactMatchName,
    this.distance,
  });

  String? value;
  String? closestNamedHex;
  bool? exactMatchName;
  int? distance;

  factory Name.fromJson(Map<String, dynamic> json) => Name(
        value: json["value"],
        closestNamedHex: json["closest_named_hex"],
        exactMatchName: json["exact_match_name"],
        distance: json["distance"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "closest_named_hex": closestNamedHex,
        "exact_match_name": exactMatchName,
        "distance": distance,
      };
}

class Rgb {
  Rgb({
    this.fraction,
    this.r,
    this.g,
    this.b,
    this.value,
  });

  RgbFraction? fraction;
  int? r;
  int? g;
  int? b;
  String? value;

  factory Rgb.fromJson(Map<String, dynamic> json) => Rgb(
        fraction: RgbFraction.fromJson(json["fraction"]),
        r: json["r"],
        g: json["g"],
        b: json["b"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "fraction": fraction!.toJson(),
        "r": r,
        "g": g,
        "b": b,
        "value": value,
      };
}

class RgbFraction {
  RgbFraction({
    this.r,
    this.g,
    this.b,
  });

  int? r;
  int? g;
  int? b;

  factory RgbFraction.fromJson(Map<String, dynamic> json) => RgbFraction(
        r: json["r"],
        g: json["g"],
        b: json["b"],
      );

  Map<String, dynamic> toJson() => {
        "r": r,
        "g": g,
        "b": b,
      };
}

class Xyz {
  Xyz({
    this.fraction,
    this.value,
    this.x,
    this.y,
    this.z,
  });

  XyzFraction? fraction;
  String? value;
  int? x;
  int? y;
  int? z;

  factory Xyz.fromJson(Map<String, dynamic> json) => Xyz(
        fraction: XyzFraction.fromJson(json["fraction"]),
        value: json["value"],
        x: json["X"],
        y: json["Y"],
        z: json["Z"],
      );

  Map<String, dynamic> toJson() => {
        "fraction": fraction!.toJson(),
        "value": value,
        "X": x,
        "Y": y,
        "Z": z,
      };
}

class XyzFraction {
  XyzFraction({
    this.x,
    this.y,
    this.z,
  });

  int? x;
  int? y;
  int? z;

  factory XyzFraction.fromJson(Map<String, dynamic> json) => XyzFraction(
        x: json["X"],
        y: json["Y"],
        z: json["Z"],
      );

  Map<String, dynamic> toJson() => {
        "X": x,
        "Y": y,
        "Z": z,
      };
}
