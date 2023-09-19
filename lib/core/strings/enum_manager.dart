enum Governorate {
  damascus,
  aleppo,
  homs,
  hama,
  latakia,
  tartus,
  raqqa,
  alHasakah,
  idlib,
  deirEzZor,
  asSuwayda,
  daraa,
  quneitra,
  ruralDamascus,
}

extension ArabicName on Governorate {
  String get arabicName {
    switch (this) {
      case Governorate.damascus:
        return 'دمشق';
      case Governorate.aleppo:
        return ' ريف دمشق';
      case Governorate.homs:
        return ' حلب';
      case Governorate.hama:
        return ' حمص';
      case Governorate.latakia:
        return ' حماة';
      case Governorate.tartus:
        return ' اللاذقية';
      case Governorate.raqqa:
        return ' طرطوس';
      case Governorate.alHasakah:
        return ' الرقة';
      case Governorate.idlib:
        return ' الحسكة';
      case Governorate.deirEzZor:
        return ' إدلب';
      case Governorate.asSuwayda:
        return ' دير الزور';
      case Governorate.daraa:
        return ' السويداء';
      case Governorate.quneitra:
        return ' درعا';
      case Governorate.ruralDamascus:
        return ' القنيطرة';
    }
  }
}
