// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moor_db.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class User extends DataClass implements Insertable<User> {
  final bool producer;
  final String accessToken;
  final String refreshToken;
  final String username;
  final String imgPath;
  final List<String> favStops;
  final List<String> favTours;
  final bool onboardEnd;
  User(
      {@required this.producer,
      @required this.accessToken,
      @required this.refreshToken,
      @required this.username,
      @required this.imgPath,
      @required this.favStops,
      @required this.favTours,
      @required this.onboardEnd});
  factory User.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final boolType = db.typeSystem.forDartType<bool>();
    final stringType = db.typeSystem.forDartType<String>();
    return User(
      producer:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}producer']),
      accessToken: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}accessToken']),
      refreshToken: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}refreshToken']),
      username: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}username']),
      imgPath:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}imgPath']),
      favStops: $UsersTable.$converter0.mapToDart(stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}favStops'])),
      favTours: $UsersTable.$converter1.mapToDart(stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}favTours'])),
      onboardEnd: boolType
          .mapFromDatabaseResponse(data['${effectivePrefix}onboardEnd']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || producer != null) {
      map['producer'] = Variable<bool>(producer);
    }
    if (!nullToAbsent || accessToken != null) {
      map['accessToken'] = Variable<String>(accessToken);
    }
    if (!nullToAbsent || refreshToken != null) {
      map['refreshToken'] = Variable<String>(refreshToken);
    }
    if (!nullToAbsent || username != null) {
      map['username'] = Variable<String>(username);
    }
    if (!nullToAbsent || imgPath != null) {
      map['imgPath'] = Variable<String>(imgPath);
    }
    if (!nullToAbsent || favStops != null) {
      final converter = $UsersTable.$converter0;
      map['favStops'] = Variable<String>(converter.mapToSql(favStops));
    }
    if (!nullToAbsent || favTours != null) {
      final converter = $UsersTable.$converter1;
      map['favTours'] = Variable<String>(converter.mapToSql(favTours));
    }
    if (!nullToAbsent || onboardEnd != null) {
      map['onboardEnd'] = Variable<bool>(onboardEnd);
    }
    return map;
  }

  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return User(
      producer: serializer.fromJson<bool>(json['producer']),
      accessToken: serializer.fromJson<String>(json['accessToken']),
      refreshToken: serializer.fromJson<String>(json['refreshToken']),
      username: serializer.fromJson<String>(json['username']),
      imgPath: serializer.fromJson<String>(json['imgPath']),
      favStops: serializer.fromJson<List<String>>(json['favStops']),
      favTours: serializer.fromJson<List<String>>(json['favTours']),
      onboardEnd: serializer.fromJson<bool>(json['onboardEnd']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'producer': serializer.toJson<bool>(producer),
      'accessToken': serializer.toJson<String>(accessToken),
      'refreshToken': serializer.toJson<String>(refreshToken),
      'username': serializer.toJson<String>(username),
      'imgPath': serializer.toJson<String>(imgPath),
      'favStops': serializer.toJson<List<String>>(favStops),
      'favTours': serializer.toJson<List<String>>(favTours),
      'onboardEnd': serializer.toJson<bool>(onboardEnd),
    };
  }

  User copyWith(
          {bool producer,
          String accessToken,
          String refreshToken,
          String username,
          String imgPath,
          List<String> favStops,
          List<String> favTours,
          bool onboardEnd}) =>
      User(
        producer: producer ?? this.producer,
        accessToken: accessToken ?? this.accessToken,
        refreshToken: refreshToken ?? this.refreshToken,
        username: username ?? this.username,
        imgPath: imgPath ?? this.imgPath,
        favStops: favStops ?? this.favStops,
        favTours: favTours ?? this.favTours,
        onboardEnd: onboardEnd ?? this.onboardEnd,
      );
  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('producer: $producer, ')
          ..write('accessToken: $accessToken, ')
          ..write('refreshToken: $refreshToken, ')
          ..write('username: $username, ')
          ..write('imgPath: $imgPath, ')
          ..write('favStops: $favStops, ')
          ..write('favTours: $favTours, ')
          ..write('onboardEnd: $onboardEnd')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      producer.hashCode,
      $mrjc(
          accessToken.hashCode,
          $mrjc(
              refreshToken.hashCode,
              $mrjc(
                  username.hashCode,
                  $mrjc(
                      imgPath.hashCode,
                      $mrjc(favStops.hashCode,
                          $mrjc(favTours.hashCode, onboardEnd.hashCode))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is User &&
          other.producer == this.producer &&
          other.accessToken == this.accessToken &&
          other.refreshToken == this.refreshToken &&
          other.username == this.username &&
          other.imgPath == this.imgPath &&
          other.favStops == this.favStops &&
          other.favTours == this.favTours &&
          other.onboardEnd == this.onboardEnd);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<bool> producer;
  final Value<String> accessToken;
  final Value<String> refreshToken;
  final Value<String> username;
  final Value<String> imgPath;
  final Value<List<String>> favStops;
  final Value<List<String>> favTours;
  final Value<bool> onboardEnd;
  const UsersCompanion({
    this.producer = const Value.absent(),
    this.accessToken = const Value.absent(),
    this.refreshToken = const Value.absent(),
    this.username = const Value.absent(),
    this.imgPath = const Value.absent(),
    this.favStops = const Value.absent(),
    this.favTours = const Value.absent(),
    this.onboardEnd = const Value.absent(),
  });
  UsersCompanion.insert({
    @required bool producer,
    this.accessToken = const Value.absent(),
    this.refreshToken = const Value.absent(),
    @required String username,
    @required String imgPath,
    this.favStops = const Value.absent(),
    this.favTours = const Value.absent(),
    this.onboardEnd = const Value.absent(),
  })  : producer = Value(producer),
        username = Value(username),
        imgPath = Value(imgPath);
  static Insertable<User> custom({
    Expression<bool> producer,
    Expression<String> accessToken,
    Expression<String> refreshToken,
    Expression<String> username,
    Expression<String> imgPath,
    Expression<String> favStops,
    Expression<String> favTours,
    Expression<bool> onboardEnd,
  }) {
    return RawValuesInsertable({
      if (producer != null) 'producer': producer,
      if (accessToken != null) 'accessToken': accessToken,
      if (refreshToken != null) 'refreshToken': refreshToken,
      if (username != null) 'username': username,
      if (imgPath != null) 'imgPath': imgPath,
      if (favStops != null) 'favStops': favStops,
      if (favTours != null) 'favTours': favTours,
      if (onboardEnd != null) 'onboardEnd': onboardEnd,
    });
  }

  UsersCompanion copyWith(
      {Value<bool> producer,
      Value<String> accessToken,
      Value<String> refreshToken,
      Value<String> username,
      Value<String> imgPath,
      Value<List<String>> favStops,
      Value<List<String>> favTours,
      Value<bool> onboardEnd}) {
    return UsersCompanion(
      producer: producer ?? this.producer,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      username: username ?? this.username,
      imgPath: imgPath ?? this.imgPath,
      favStops: favStops ?? this.favStops,
      favTours: favTours ?? this.favTours,
      onboardEnd: onboardEnd ?? this.onboardEnd,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (producer.present) {
      map['producer'] = Variable<bool>(producer.value);
    }
    if (accessToken.present) {
      map['accessToken'] = Variable<String>(accessToken.value);
    }
    if (refreshToken.present) {
      map['refreshToken'] = Variable<String>(refreshToken.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (imgPath.present) {
      map['imgPath'] = Variable<String>(imgPath.value);
    }
    if (favStops.present) {
      final converter = $UsersTable.$converter0;
      map['favStops'] = Variable<String>(converter.mapToSql(favStops.value));
    }
    if (favTours.present) {
      final converter = $UsersTable.$converter1;
      map['favTours'] = Variable<String>(converter.mapToSql(favTours.value));
    }
    if (onboardEnd.present) {
      map['onboardEnd'] = Variable<bool>(onboardEnd.value);
    }
    return map;
  }
}

class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  final GeneratedDatabase _db;
  final String _alias;
  $UsersTable(this._db, [this._alias]);
  final VerificationMeta _producerMeta = const VerificationMeta('producer');
  GeneratedBoolColumn _producer;
  @override
  GeneratedBoolColumn get producer => _producer ??= _constructProducer();
  GeneratedBoolColumn _constructProducer() {
    return GeneratedBoolColumn(
      'producer',
      $tableName,
      false,
    );
  }

  final VerificationMeta _accessTokenMeta =
      const VerificationMeta('accessToken');
  GeneratedTextColumn _accessToken;
  @override
  GeneratedTextColumn get accessToken =>
      _accessToken ??= _constructAccessToken();
  GeneratedTextColumn _constructAccessToken() {
    return GeneratedTextColumn('accessToken', $tableName, false,
        defaultValue: const Constant(""));
  }

  final VerificationMeta _refreshTokenMeta =
      const VerificationMeta('refreshToken');
  GeneratedTextColumn _refreshToken;
  @override
  GeneratedTextColumn get refreshToken =>
      _refreshToken ??= _constructRefreshToken();
  GeneratedTextColumn _constructRefreshToken() {
    return GeneratedTextColumn('refreshToken', $tableName, false,
        defaultValue: const Constant(""));
  }

  final VerificationMeta _usernameMeta = const VerificationMeta('username');
  GeneratedTextColumn _username;
  @override
  GeneratedTextColumn get username => _username ??= _constructUsername();
  GeneratedTextColumn _constructUsername() {
    return GeneratedTextColumn(
      'username',
      $tableName,
      false,
    );
  }

  final VerificationMeta _imgPathMeta = const VerificationMeta('imgPath');
  GeneratedTextColumn _imgPath;
  @override
  GeneratedTextColumn get imgPath => _imgPath ??= _constructImgPath();
  GeneratedTextColumn _constructImgPath() {
    return GeneratedTextColumn(
      'imgPath',
      $tableName,
      false,
    );
  }

  final VerificationMeta _favStopsMeta = const VerificationMeta('favStops');
  GeneratedTextColumn _favStops;
  @override
  GeneratedTextColumn get favStops => _favStops ??= _constructFavStops();
  GeneratedTextColumn _constructFavStops() {
    return GeneratedTextColumn('favStops', $tableName, false,
        defaultValue: const Constant(""));
  }

  final VerificationMeta _favToursMeta = const VerificationMeta('favTours');
  GeneratedTextColumn _favTours;
  @override
  GeneratedTextColumn get favTours => _favTours ??= _constructFavTours();
  GeneratedTextColumn _constructFavTours() {
    return GeneratedTextColumn('favTours', $tableName, false,
        defaultValue: const Constant(""));
  }

  final VerificationMeta _onboardEndMeta = const VerificationMeta('onboardEnd');
  GeneratedBoolColumn _onboardEnd;
  @override
  GeneratedBoolColumn get onboardEnd => _onboardEnd ??= _constructOnboardEnd();
  GeneratedBoolColumn _constructOnboardEnd() {
    return GeneratedBoolColumn('onboardEnd', $tableName, false,
        defaultValue: const Constant(false));
  }

  @override
  List<GeneratedColumn> get $columns => [
        producer,
        accessToken,
        refreshToken,
        username,
        imgPath,
        favStops,
        favTours,
        onboardEnd
      ];
  @override
  $UsersTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'users';
  @override
  final String actualTableName = 'users';
  @override
  VerificationContext validateIntegrity(Insertable<User> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('producer')) {
      context.handle(_producerMeta,
          producer.isAcceptableOrUnknown(data['producer'], _producerMeta));
    } else if (isInserting) {
      context.missing(_producerMeta);
    }
    if (data.containsKey('accessToken')) {
      context.handle(
          _accessTokenMeta,
          accessToken.isAcceptableOrUnknown(
              data['accessToken'], _accessTokenMeta));
    }
    if (data.containsKey('refreshToken')) {
      context.handle(
          _refreshTokenMeta,
          refreshToken.isAcceptableOrUnknown(
              data['refreshToken'], _refreshTokenMeta));
    }
    if (data.containsKey('username')) {
      context.handle(_usernameMeta,
          username.isAcceptableOrUnknown(data['username'], _usernameMeta));
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('imgPath')) {
      context.handle(_imgPathMeta,
          imgPath.isAcceptableOrUnknown(data['imgPath'], _imgPathMeta));
    } else if (isInserting) {
      context.missing(_imgPathMeta);
    }
    context.handle(_favStopsMeta, const VerificationResult.success());
    context.handle(_favToursMeta, const VerificationResult.success());
    if (data.containsKey('onboardEnd')) {
      context.handle(
          _onboardEndMeta,
          onboardEnd.isAcceptableOrUnknown(
              data['onboardEnd'], _onboardEndMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {username};
  @override
  User map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return User.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(_db, alias);
  }

  static TypeConverter<List<String>, String> $converter0 =
      StringListConverter();
  static TypeConverter<List<String>, String> $converter1 =
      StringListConverter();
}

class Badge extends DataClass implements Insertable<Badge> {
  final String name;
  final double current;
  final double toGet;
  final Color color;
  final String imgPath;
  Badge(
      {@required this.name,
      @required this.current,
      @required this.toGet,
      @required this.color,
      @required this.imgPath});
  factory Badge.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final doubleType = db.typeSystem.forDartType<double>();
    final intType = db.typeSystem.forDartType<int>();
    return Badge(
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      current:
          doubleType.mapFromDatabaseResponse(data['${effectivePrefix}current']),
      toGet:
          doubleType.mapFromDatabaseResponse(data['${effectivePrefix}to_get']),
      color: $BadgesTable.$converter0.mapToDart(
          intType.mapFromDatabaseResponse(data['${effectivePrefix}color'])),
      imgPath: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}img_path']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || current != null) {
      map['current'] = Variable<double>(current);
    }
    if (!nullToAbsent || toGet != null) {
      map['to_get'] = Variable<double>(toGet);
    }
    if (!nullToAbsent || color != null) {
      final converter = $BadgesTable.$converter0;
      map['color'] = Variable<int>(converter.mapToSql(color));
    }
    if (!nullToAbsent || imgPath != null) {
      map['img_path'] = Variable<String>(imgPath);
    }
    return map;
  }

  factory Badge.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Badge(
      name: serializer.fromJson<String>(json['name']),
      current: serializer.fromJson<double>(json['current']),
      toGet: serializer.fromJson<double>(json['toGet']),
      color: serializer.fromJson<Color>(json['color']),
      imgPath: serializer.fromJson<String>(json['imgPath']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'name': serializer.toJson<String>(name),
      'current': serializer.toJson<double>(current),
      'toGet': serializer.toJson<double>(toGet),
      'color': serializer.toJson<Color>(color),
      'imgPath': serializer.toJson<String>(imgPath),
    };
  }

  Badge copyWith(
          {String name,
          double current,
          double toGet,
          Color color,
          String imgPath}) =>
      Badge(
        name: name ?? this.name,
        current: current ?? this.current,
        toGet: toGet ?? this.toGet,
        color: color ?? this.color,
        imgPath: imgPath ?? this.imgPath,
      );
  @override
  String toString() {
    return (StringBuffer('Badge(')
          ..write('name: $name, ')
          ..write('current: $current, ')
          ..write('toGet: $toGet, ')
          ..write('color: $color, ')
          ..write('imgPath: $imgPath')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      name.hashCode,
      $mrjc(current.hashCode,
          $mrjc(toGet.hashCode, $mrjc(color.hashCode, imgPath.hashCode)))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Badge &&
          other.name == this.name &&
          other.current == this.current &&
          other.toGet == this.toGet &&
          other.color == this.color &&
          other.imgPath == this.imgPath);
}

class BadgesCompanion extends UpdateCompanion<Badge> {
  final Value<String> name;
  final Value<double> current;
  final Value<double> toGet;
  final Value<Color> color;
  final Value<String> imgPath;
  const BadgesCompanion({
    this.name = const Value.absent(),
    this.current = const Value.absent(),
    this.toGet = const Value.absent(),
    this.color = const Value.absent(),
    this.imgPath = const Value.absent(),
  });
  BadgesCompanion.insert({
    @required String name,
    this.current = const Value.absent(),
    @required double toGet,
    this.color = const Value.absent(),
    @required String imgPath,
  })  : name = Value(name),
        toGet = Value(toGet),
        imgPath = Value(imgPath);
  static Insertable<Badge> custom({
    Expression<String> name,
    Expression<double> current,
    Expression<double> toGet,
    Expression<int> color,
    Expression<String> imgPath,
  }) {
    return RawValuesInsertable({
      if (name != null) 'name': name,
      if (current != null) 'current': current,
      if (toGet != null) 'to_get': toGet,
      if (color != null) 'color': color,
      if (imgPath != null) 'img_path': imgPath,
    });
  }

  BadgesCompanion copyWith(
      {Value<String> name,
      Value<double> current,
      Value<double> toGet,
      Value<Color> color,
      Value<String> imgPath}) {
    return BadgesCompanion(
      name: name ?? this.name,
      current: current ?? this.current,
      toGet: toGet ?? this.toGet,
      color: color ?? this.color,
      imgPath: imgPath ?? this.imgPath,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (current.present) {
      map['current'] = Variable<double>(current.value);
    }
    if (toGet.present) {
      map['to_get'] = Variable<double>(toGet.value);
    }
    if (color.present) {
      final converter = $BadgesTable.$converter0;
      map['color'] = Variable<int>(converter.mapToSql(color.value));
    }
    if (imgPath.present) {
      map['img_path'] = Variable<String>(imgPath.value);
    }
    return map;
  }
}

class $BadgesTable extends Badges with TableInfo<$BadgesTable, Badge> {
  final GeneratedDatabase _db;
  final String _alias;
  $BadgesTable(this._db, [this._alias]);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _currentMeta = const VerificationMeta('current');
  GeneratedRealColumn _current;
  @override
  GeneratedRealColumn get current => _current ??= _constructCurrent();
  GeneratedRealColumn _constructCurrent() {
    return GeneratedRealColumn('current', $tableName, false,
        defaultValue: const Constant(0.0));
  }

  final VerificationMeta _toGetMeta = const VerificationMeta('toGet');
  GeneratedRealColumn _toGet;
  @override
  GeneratedRealColumn get toGet => _toGet ??= _constructToGet();
  GeneratedRealColumn _constructToGet() {
    return GeneratedRealColumn(
      'to_get',
      $tableName,
      false,
    );
  }

  final VerificationMeta _colorMeta = const VerificationMeta('color');
  GeneratedIntColumn _color;
  @override
  GeneratedIntColumn get color => _color ??= _constructColor();
  GeneratedIntColumn _constructColor() {
    return GeneratedIntColumn('color', $tableName, false,
        defaultValue: const Constant(0));
  }

  final VerificationMeta _imgPathMeta = const VerificationMeta('imgPath');
  GeneratedTextColumn _imgPath;
  @override
  GeneratedTextColumn get imgPath => _imgPath ??= _constructImgPath();
  GeneratedTextColumn _constructImgPath() {
    return GeneratedTextColumn(
      'img_path',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [name, current, toGet, color, imgPath];
  @override
  $BadgesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'badges';
  @override
  final String actualTableName = 'badges';
  @override
  VerificationContext validateIntegrity(Insertable<Badge> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('current')) {
      context.handle(_currentMeta,
          current.isAcceptableOrUnknown(data['current'], _currentMeta));
    }
    if (data.containsKey('to_get')) {
      context.handle(
          _toGetMeta, toGet.isAcceptableOrUnknown(data['to_get'], _toGetMeta));
    } else if (isInserting) {
      context.missing(_toGetMeta);
    }
    context.handle(_colorMeta, const VerificationResult.success());
    if (data.containsKey('img_path')) {
      context.handle(_imgPathMeta,
          imgPath.isAcceptableOrUnknown(data['img_path'], _imgPathMeta));
    } else if (isInserting) {
      context.missing(_imgPathMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {name};
  @override
  Badge map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Badge.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $BadgesTable createAlias(String alias) {
    return $BadgesTable(_db, alias);
  }

  static TypeConverter<Color, int> $converter0 = ColorConverter();
}

class Stop extends DataClass implements Insertable<Stop> {
  final String id;
  final List<String> images;
  final String name;
  final String descr;
  final String time;
  final String creator;
  final String division;
  final String artType;
  final String material;
  final String size;
  final String location;
  final String interContext;
  Stop(
      {@required this.id,
      @required this.images,
      @required this.name,
      @required this.descr,
      this.time,
      this.creator,
      this.division,
      this.artType,
      this.material,
      this.size,
      this.location,
      this.interContext});
  factory Stop.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return Stop(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      images: $StopsTable.$converter0.mapToDart(
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}images'])),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      descr:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}descr']),
      time: stringType.mapFromDatabaseResponse(data['${effectivePrefix}time']),
      creator:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}creator']),
      division: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}division']),
      artType: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}art_type']),
      material: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}material']),
      size: stringType.mapFromDatabaseResponse(data['${effectivePrefix}size']),
      location: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}location']),
      interContext: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}inter_context']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || images != null) {
      final converter = $StopsTable.$converter0;
      map['images'] = Variable<String>(converter.mapToSql(images));
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || descr != null) {
      map['descr'] = Variable<String>(descr);
    }
    if (!nullToAbsent || time != null) {
      map['time'] = Variable<String>(time);
    }
    if (!nullToAbsent || creator != null) {
      map['creator'] = Variable<String>(creator);
    }
    if (!nullToAbsent || division != null) {
      map['division'] = Variable<String>(division);
    }
    if (!nullToAbsent || artType != null) {
      map['art_type'] = Variable<String>(artType);
    }
    if (!nullToAbsent || material != null) {
      map['material'] = Variable<String>(material);
    }
    if (!nullToAbsent || size != null) {
      map['size'] = Variable<String>(size);
    }
    if (!nullToAbsent || location != null) {
      map['location'] = Variable<String>(location);
    }
    if (!nullToAbsent || interContext != null) {
      map['inter_context'] = Variable<String>(interContext);
    }
    return map;
  }

  factory Stop.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Stop(
      id: serializer.fromJson<String>(json['id']),
      images: serializer.fromJson<List<String>>(json['images']),
      name: serializer.fromJson<String>(json['name']),
      descr: serializer.fromJson<String>(json['descr']),
      time: serializer.fromJson<String>(json['time']),
      creator: serializer.fromJson<String>(json['creator']),
      division: serializer.fromJson<String>(json['division']),
      artType: serializer.fromJson<String>(json['artType']),
      material: serializer.fromJson<String>(json['material']),
      size: serializer.fromJson<String>(json['size']),
      location: serializer.fromJson<String>(json['location']),
      interContext: serializer.fromJson<String>(json['interContext']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'images': serializer.toJson<List<String>>(images),
      'name': serializer.toJson<String>(name),
      'descr': serializer.toJson<String>(descr),
      'time': serializer.toJson<String>(time),
      'creator': serializer.toJson<String>(creator),
      'division': serializer.toJson<String>(division),
      'artType': serializer.toJson<String>(artType),
      'material': serializer.toJson<String>(material),
      'size': serializer.toJson<String>(size),
      'location': serializer.toJson<String>(location),
      'interContext': serializer.toJson<String>(interContext),
    };
  }

  Stop copyWith(
          {String id,
          List<String> images,
          String name,
          String descr,
          String time,
          String creator,
          String division,
          String artType,
          String material,
          String size,
          String location,
          String interContext}) =>
      Stop(
        id: id ?? this.id,
        images: images ?? this.images,
        name: name ?? this.name,
        descr: descr ?? this.descr,
        time: time ?? this.time,
        creator: creator ?? this.creator,
        division: division ?? this.division,
        artType: artType ?? this.artType,
        material: material ?? this.material,
        size: size ?? this.size,
        location: location ?? this.location,
        interContext: interContext ?? this.interContext,
      );
  @override
  String toString() {
    return (StringBuffer('Stop(')
          ..write('id: $id, ')
          ..write('images: $images, ')
          ..write('name: $name, ')
          ..write('descr: $descr, ')
          ..write('time: $time, ')
          ..write('creator: $creator, ')
          ..write('division: $division, ')
          ..write('artType: $artType, ')
          ..write('material: $material, ')
          ..write('size: $size, ')
          ..write('location: $location, ')
          ..write('interContext: $interContext')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          images.hashCode,
          $mrjc(
              name.hashCode,
              $mrjc(
                  descr.hashCode,
                  $mrjc(
                      time.hashCode,
                      $mrjc(
                          creator.hashCode,
                          $mrjc(
                              division.hashCode,
                              $mrjc(
                                  artType.hashCode,
                                  $mrjc(
                                      material.hashCode,
                                      $mrjc(
                                          size.hashCode,
                                          $mrjc(location.hashCode,
                                              interContext.hashCode))))))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Stop &&
          other.id == this.id &&
          other.images == this.images &&
          other.name == this.name &&
          other.descr == this.descr &&
          other.time == this.time &&
          other.creator == this.creator &&
          other.division == this.division &&
          other.artType == this.artType &&
          other.material == this.material &&
          other.size == this.size &&
          other.location == this.location &&
          other.interContext == this.interContext);
}

class StopsCompanion extends UpdateCompanion<Stop> {
  final Value<String> id;
  final Value<List<String>> images;
  final Value<String> name;
  final Value<String> descr;
  final Value<String> time;
  final Value<String> creator;
  final Value<String> division;
  final Value<String> artType;
  final Value<String> material;
  final Value<String> size;
  final Value<String> location;
  final Value<String> interContext;
  const StopsCompanion({
    this.id = const Value.absent(),
    this.images = const Value.absent(),
    this.name = const Value.absent(),
    this.descr = const Value.absent(),
    this.time = const Value.absent(),
    this.creator = const Value.absent(),
    this.division = const Value.absent(),
    this.artType = const Value.absent(),
    this.material = const Value.absent(),
    this.size = const Value.absent(),
    this.location = const Value.absent(),
    this.interContext = const Value.absent(),
  });
  StopsCompanion.insert({
    @required String id,
    @required List<String> images,
    @required String name,
    @required String descr,
    this.time = const Value.absent(),
    this.creator = const Value.absent(),
    this.division = const Value.absent(),
    this.artType = const Value.absent(),
    this.material = const Value.absent(),
    this.size = const Value.absent(),
    this.location = const Value.absent(),
    this.interContext = const Value.absent(),
  })  : id = Value(id),
        images = Value(images),
        name = Value(name),
        descr = Value(descr);
  static Insertable<Stop> custom({
    Expression<String> id,
    Expression<String> images,
    Expression<String> name,
    Expression<String> descr,
    Expression<String> time,
    Expression<String> creator,
    Expression<String> division,
    Expression<String> artType,
    Expression<String> material,
    Expression<String> size,
    Expression<String> location,
    Expression<String> interContext,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (images != null) 'images': images,
      if (name != null) 'name': name,
      if (descr != null) 'descr': descr,
      if (time != null) 'time': time,
      if (creator != null) 'creator': creator,
      if (division != null) 'division': division,
      if (artType != null) 'art_type': artType,
      if (material != null) 'material': material,
      if (size != null) 'size': size,
      if (location != null) 'location': location,
      if (interContext != null) 'inter_context': interContext,
    });
  }

  StopsCompanion copyWith(
      {Value<String> id,
      Value<List<String>> images,
      Value<String> name,
      Value<String> descr,
      Value<String> time,
      Value<String> creator,
      Value<String> division,
      Value<String> artType,
      Value<String> material,
      Value<String> size,
      Value<String> location,
      Value<String> interContext}) {
    return StopsCompanion(
      id: id ?? this.id,
      images: images ?? this.images,
      name: name ?? this.name,
      descr: descr ?? this.descr,
      time: time ?? this.time,
      creator: creator ?? this.creator,
      division: division ?? this.division,
      artType: artType ?? this.artType,
      material: material ?? this.material,
      size: size ?? this.size,
      location: location ?? this.location,
      interContext: interContext ?? this.interContext,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (images.present) {
      final converter = $StopsTable.$converter0;
      map['images'] = Variable<String>(converter.mapToSql(images.value));
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (descr.present) {
      map['descr'] = Variable<String>(descr.value);
    }
    if (time.present) {
      map['time'] = Variable<String>(time.value);
    }
    if (creator.present) {
      map['creator'] = Variable<String>(creator.value);
    }
    if (division.present) {
      map['division'] = Variable<String>(division.value);
    }
    if (artType.present) {
      map['art_type'] = Variable<String>(artType.value);
    }
    if (material.present) {
      map['material'] = Variable<String>(material.value);
    }
    if (size.present) {
      map['size'] = Variable<String>(size.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (interContext.present) {
      map['inter_context'] = Variable<String>(interContext.value);
    }
    return map;
  }
}

class $StopsTable extends Stops with TableInfo<$StopsTable, Stop> {
  final GeneratedDatabase _db;
  final String _alias;
  $StopsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _imagesMeta = const VerificationMeta('images');
  GeneratedTextColumn _images;
  @override
  GeneratedTextColumn get images => _images ??= _constructImages();
  GeneratedTextColumn _constructImages() {
    return GeneratedTextColumn(
      'images',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _descrMeta = const VerificationMeta('descr');
  GeneratedTextColumn _descr;
  @override
  GeneratedTextColumn get descr => _descr ??= _constructDescr();
  GeneratedTextColumn _constructDescr() {
    return GeneratedTextColumn(
      'descr',
      $tableName,
      false,
    );
  }

  final VerificationMeta _timeMeta = const VerificationMeta('time');
  GeneratedTextColumn _time;
  @override
  GeneratedTextColumn get time => _time ??= _constructTime();
  GeneratedTextColumn _constructTime() {
    return GeneratedTextColumn(
      'time',
      $tableName,
      true,
    );
  }

  final VerificationMeta _creatorMeta = const VerificationMeta('creator');
  GeneratedTextColumn _creator;
  @override
  GeneratedTextColumn get creator => _creator ??= _constructCreator();
  GeneratedTextColumn _constructCreator() {
    return GeneratedTextColumn(
      'creator',
      $tableName,
      true,
    );
  }

  final VerificationMeta _divisionMeta = const VerificationMeta('division');
  GeneratedTextColumn _division;
  @override
  GeneratedTextColumn get division => _division ??= _constructDivision();
  GeneratedTextColumn _constructDivision() {
    return GeneratedTextColumn('division', $tableName, true,
        $customConstraints: 'REFERENCES divisions(name)');
  }

  final VerificationMeta _artTypeMeta = const VerificationMeta('artType');
  GeneratedTextColumn _artType;
  @override
  GeneratedTextColumn get artType => _artType ??= _constructArtType();
  GeneratedTextColumn _constructArtType() {
    return GeneratedTextColumn(
      'art_type',
      $tableName,
      true,
    );
  }

  final VerificationMeta _materialMeta = const VerificationMeta('material');
  GeneratedTextColumn _material;
  @override
  GeneratedTextColumn get material => _material ??= _constructMaterial();
  GeneratedTextColumn _constructMaterial() {
    return GeneratedTextColumn(
      'material',
      $tableName,
      true,
    );
  }

  final VerificationMeta _sizeMeta = const VerificationMeta('size');
  GeneratedTextColumn _size;
  @override
  GeneratedTextColumn get size => _size ??= _constructSize();
  GeneratedTextColumn _constructSize() {
    return GeneratedTextColumn(
      'size',
      $tableName,
      true,
    );
  }

  final VerificationMeta _locationMeta = const VerificationMeta('location');
  GeneratedTextColumn _location;
  @override
  GeneratedTextColumn get location => _location ??= _constructLocation();
  GeneratedTextColumn _constructLocation() {
    return GeneratedTextColumn(
      'location',
      $tableName,
      true,
    );
  }

  final VerificationMeta _interContextMeta =
      const VerificationMeta('interContext');
  GeneratedTextColumn _interContext;
  @override
  GeneratedTextColumn get interContext =>
      _interContext ??= _constructInterContext();
  GeneratedTextColumn _constructInterContext() {
    return GeneratedTextColumn(
      'inter_context',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        images,
        name,
        descr,
        time,
        creator,
        division,
        artType,
        material,
        size,
        location,
        interContext
      ];
  @override
  $StopsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'stops';
  @override
  final String actualTableName = 'stops';
  @override
  VerificationContext validateIntegrity(Insertable<Stop> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    context.handle(_imagesMeta, const VerificationResult.success());
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('descr')) {
      context.handle(
          _descrMeta, descr.isAcceptableOrUnknown(data['descr'], _descrMeta));
    } else if (isInserting) {
      context.missing(_descrMeta);
    }
    if (data.containsKey('time')) {
      context.handle(
          _timeMeta, time.isAcceptableOrUnknown(data['time'], _timeMeta));
    }
    if (data.containsKey('creator')) {
      context.handle(_creatorMeta,
          creator.isAcceptableOrUnknown(data['creator'], _creatorMeta));
    }
    if (data.containsKey('division')) {
      context.handle(_divisionMeta,
          division.isAcceptableOrUnknown(data['division'], _divisionMeta));
    }
    if (data.containsKey('art_type')) {
      context.handle(_artTypeMeta,
          artType.isAcceptableOrUnknown(data['art_type'], _artTypeMeta));
    }
    if (data.containsKey('material')) {
      context.handle(_materialMeta,
          material.isAcceptableOrUnknown(data['material'], _materialMeta));
    }
    if (data.containsKey('size')) {
      context.handle(
          _sizeMeta, size.isAcceptableOrUnknown(data['size'], _sizeMeta));
    }
    if (data.containsKey('location')) {
      context.handle(_locationMeta,
          location.isAcceptableOrUnknown(data['location'], _locationMeta));
    }
    if (data.containsKey('inter_context')) {
      context.handle(
          _interContextMeta,
          interContext.isAcceptableOrUnknown(
              data['inter_context'], _interContextMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Stop map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Stop.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $StopsTable createAlias(String alias) {
    return $StopsTable(_db, alias);
  }

  static TypeConverter<List<String>, String> $converter0 =
      StringListConverter();
}

class Division extends DataClass implements Insertable<Division> {
  final String name;
  final Color color;
  Division({@required this.name, @required this.color});
  factory Division.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final intType = db.typeSystem.forDartType<int>();
    return Division(
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      color: $DivisionsTable.$converter0.mapToDart(
          intType.mapFromDatabaseResponse(data['${effectivePrefix}color'])),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || color != null) {
      final converter = $DivisionsTable.$converter0;
      map['color'] = Variable<int>(converter.mapToSql(color));
    }
    return map;
  }

  factory Division.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Division(
      name: serializer.fromJson<String>(json['name']),
      color: serializer.fromJson<Color>(json['color']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'name': serializer.toJson<String>(name),
      'color': serializer.toJson<Color>(color),
    };
  }

  Division copyWith({String name, Color color}) => Division(
        name: name ?? this.name,
        color: color ?? this.color,
      );
  @override
  String toString() {
    return (StringBuffer('Division(')
          ..write('name: $name, ')
          ..write('color: $color')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(name.hashCode, color.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Division &&
          other.name == this.name &&
          other.color == this.color);
}

class DivisionsCompanion extends UpdateCompanion<Division> {
  final Value<String> name;
  final Value<Color> color;
  const DivisionsCompanion({
    this.name = const Value.absent(),
    this.color = const Value.absent(),
  });
  DivisionsCompanion.insert({
    @required String name,
    this.color = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Division> custom({
    Expression<String> name,
    Expression<int> color,
  }) {
    return RawValuesInsertable({
      if (name != null) 'name': name,
      if (color != null) 'color': color,
    });
  }

  DivisionsCompanion copyWith({Value<String> name, Value<Color> color}) {
    return DivisionsCompanion(
      name: name ?? this.name,
      color: color ?? this.color,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (color.present) {
      final converter = $DivisionsTable.$converter0;
      map['color'] = Variable<int>(converter.mapToSql(color.value));
    }
    return map;
  }
}

class $DivisionsTable extends Divisions
    with TableInfo<$DivisionsTable, Division> {
  final GeneratedDatabase _db;
  final String _alias;
  $DivisionsTable(this._db, [this._alias]);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _colorMeta = const VerificationMeta('color');
  GeneratedIntColumn _color;
  @override
  GeneratedIntColumn get color => _color ??= _constructColor();
  GeneratedIntColumn _constructColor() {
    return GeneratedIntColumn('color', $tableName, false,
        defaultValue: const Constant(0xFFFFFFFF));
  }

  @override
  List<GeneratedColumn> get $columns => [name, color];
  @override
  $DivisionsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'divisions';
  @override
  final String actualTableName = 'divisions';
  @override
  VerificationContext validateIntegrity(Insertable<Division> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    context.handle(_colorMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {name};
  @override
  Division map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Division.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $DivisionsTable createAlias(String alias) {
    return $DivisionsTable(_db, alias);
  }

  static TypeConverter<Color, int> $converter0 = ColorConverter();
}

class Tour extends DataClass implements Insertable<Tour> {
  final int id;
  final String onlineId;
  final String name;
  final String author;
  final double difficulty;
  final DateTime creationTime;
  final String desc;
  Tour(
      {@required this.id,
      @required this.onlineId,
      @required this.name,
      @required this.author,
      @required this.difficulty,
      @required this.creationTime,
      @required this.desc});
  factory Tour.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final doubleType = db.typeSystem.forDartType<double>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Tour(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      onlineId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}online_id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      author:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}author']),
      difficulty: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}difficulty']),
      creationTime: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}creation_time']),
      desc: stringType.mapFromDatabaseResponse(data['${effectivePrefix}desc']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || onlineId != null) {
      map['online_id'] = Variable<String>(onlineId);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || author != null) {
      map['author'] = Variable<String>(author);
    }
    if (!nullToAbsent || difficulty != null) {
      map['difficulty'] = Variable<double>(difficulty);
    }
    if (!nullToAbsent || creationTime != null) {
      map['creation_time'] = Variable<DateTime>(creationTime);
    }
    if (!nullToAbsent || desc != null) {
      map['desc'] = Variable<String>(desc);
    }
    return map;
  }

  factory Tour.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Tour(
      id: serializer.fromJson<int>(json['id']),
      onlineId: serializer.fromJson<String>(json['onlineId']),
      name: serializer.fromJson<String>(json['name']),
      author: serializer.fromJson<String>(json['author']),
      difficulty: serializer.fromJson<double>(json['difficulty']),
      creationTime: serializer.fromJson<DateTime>(json['creationTime']),
      desc: serializer.fromJson<String>(json['desc']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'onlineId': serializer.toJson<String>(onlineId),
      'name': serializer.toJson<String>(name),
      'author': serializer.toJson<String>(author),
      'difficulty': serializer.toJson<double>(difficulty),
      'creationTime': serializer.toJson<DateTime>(creationTime),
      'desc': serializer.toJson<String>(desc),
    };
  }

  Tour copyWith(
          {int id,
          String onlineId,
          String name,
          String author,
          double difficulty,
          DateTime creationTime,
          String desc}) =>
      Tour(
        id: id ?? this.id,
        onlineId: onlineId ?? this.onlineId,
        name: name ?? this.name,
        author: author ?? this.author,
        difficulty: difficulty ?? this.difficulty,
        creationTime: creationTime ?? this.creationTime,
        desc: desc ?? this.desc,
      );
  @override
  String toString() {
    return (StringBuffer('Tour(')
          ..write('id: $id, ')
          ..write('onlineId: $onlineId, ')
          ..write('name: $name, ')
          ..write('author: $author, ')
          ..write('difficulty: $difficulty, ')
          ..write('creationTime: $creationTime, ')
          ..write('desc: $desc')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          onlineId.hashCode,
          $mrjc(
              name.hashCode,
              $mrjc(
                  author.hashCode,
                  $mrjc(difficulty.hashCode,
                      $mrjc(creationTime.hashCode, desc.hashCode)))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Tour &&
          other.id == this.id &&
          other.onlineId == this.onlineId &&
          other.name == this.name &&
          other.author == this.author &&
          other.difficulty == this.difficulty &&
          other.creationTime == this.creationTime &&
          other.desc == this.desc);
}

class ToursCompanion extends UpdateCompanion<Tour> {
  final Value<int> id;
  final Value<String> onlineId;
  final Value<String> name;
  final Value<String> author;
  final Value<double> difficulty;
  final Value<DateTime> creationTime;
  final Value<String> desc;
  const ToursCompanion({
    this.id = const Value.absent(),
    this.onlineId = const Value.absent(),
    this.name = const Value.absent(),
    this.author = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.creationTime = const Value.absent(),
    this.desc = const Value.absent(),
  });
  ToursCompanion.insert({
    this.id = const Value.absent(),
    @required String onlineId,
    @required String name,
    @required String author,
    @required double difficulty,
    @required DateTime creationTime,
    @required String desc,
  })  : onlineId = Value(onlineId),
        name = Value(name),
        author = Value(author),
        difficulty = Value(difficulty),
        creationTime = Value(creationTime),
        desc = Value(desc);
  static Insertable<Tour> custom({
    Expression<int> id,
    Expression<String> onlineId,
    Expression<String> name,
    Expression<String> author,
    Expression<double> difficulty,
    Expression<DateTime> creationTime,
    Expression<String> desc,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (onlineId != null) 'online_id': onlineId,
      if (name != null) 'name': name,
      if (author != null) 'author': author,
      if (difficulty != null) 'difficulty': difficulty,
      if (creationTime != null) 'creation_time': creationTime,
      if (desc != null) 'desc': desc,
    });
  }

  ToursCompanion copyWith(
      {Value<int> id,
      Value<String> onlineId,
      Value<String> name,
      Value<String> author,
      Value<double> difficulty,
      Value<DateTime> creationTime,
      Value<String> desc}) {
    return ToursCompanion(
      id: id ?? this.id,
      onlineId: onlineId ?? this.onlineId,
      name: name ?? this.name,
      author: author ?? this.author,
      difficulty: difficulty ?? this.difficulty,
      creationTime: creationTime ?? this.creationTime,
      desc: desc ?? this.desc,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (onlineId.present) {
      map['online_id'] = Variable<String>(onlineId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (author.present) {
      map['author'] = Variable<String>(author.value);
    }
    if (difficulty.present) {
      map['difficulty'] = Variable<double>(difficulty.value);
    }
    if (creationTime.present) {
      map['creation_time'] = Variable<DateTime>(creationTime.value);
    }
    if (desc.present) {
      map['desc'] = Variable<String>(desc.value);
    }
    return map;
  }
}

class $ToursTable extends Tours with TableInfo<$ToursTable, Tour> {
  final GeneratedDatabase _db;
  final String _alias;
  $ToursTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _onlineIdMeta = const VerificationMeta('onlineId');
  GeneratedTextColumn _onlineId;
  @override
  GeneratedTextColumn get onlineId => _onlineId ??= _constructOnlineId();
  GeneratedTextColumn _constructOnlineId() {
    return GeneratedTextColumn(
      'online_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _authorMeta = const VerificationMeta('author');
  GeneratedTextColumn _author;
  @override
  GeneratedTextColumn get author => _author ??= _constructAuthor();
  GeneratedTextColumn _constructAuthor() {
    return GeneratedTextColumn(
      'author',
      $tableName,
      false,
    );
  }

  final VerificationMeta _difficultyMeta = const VerificationMeta('difficulty');
  GeneratedRealColumn _difficulty;
  @override
  GeneratedRealColumn get difficulty => _difficulty ??= _constructDifficulty();
  GeneratedRealColumn _constructDifficulty() {
    return GeneratedRealColumn(
      'difficulty',
      $tableName,
      false,
    );
  }

  final VerificationMeta _creationTimeMeta =
      const VerificationMeta('creationTime');
  GeneratedDateTimeColumn _creationTime;
  @override
  GeneratedDateTimeColumn get creationTime =>
      _creationTime ??= _constructCreationTime();
  GeneratedDateTimeColumn _constructCreationTime() {
    return GeneratedDateTimeColumn(
      'creation_time',
      $tableName,
      false,
    );
  }

  final VerificationMeta _descMeta = const VerificationMeta('desc');
  GeneratedTextColumn _desc;
  @override
  GeneratedTextColumn get desc => _desc ??= _constructDesc();
  GeneratedTextColumn _constructDesc() {
    return GeneratedTextColumn(
      'desc',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, onlineId, name, author, difficulty, creationTime, desc];
  @override
  $ToursTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'tours';
  @override
  final String actualTableName = 'tours';
  @override
  VerificationContext validateIntegrity(Insertable<Tour> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('online_id')) {
      context.handle(_onlineIdMeta,
          onlineId.isAcceptableOrUnknown(data['online_id'], _onlineIdMeta));
    } else if (isInserting) {
      context.missing(_onlineIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('author')) {
      context.handle(_authorMeta,
          author.isAcceptableOrUnknown(data['author'], _authorMeta));
    } else if (isInserting) {
      context.missing(_authorMeta);
    }
    if (data.containsKey('difficulty')) {
      context.handle(
          _difficultyMeta,
          difficulty.isAcceptableOrUnknown(
              data['difficulty'], _difficultyMeta));
    } else if (isInserting) {
      context.missing(_difficultyMeta);
    }
    if (data.containsKey('creation_time')) {
      context.handle(
          _creationTimeMeta,
          creationTime.isAcceptableOrUnknown(
              data['creation_time'], _creationTimeMeta));
    } else if (isInserting) {
      context.missing(_creationTimeMeta);
    }
    if (data.containsKey('desc')) {
      context.handle(
          _descMeta, desc.isAcceptableOrUnknown(data['desc'], _descMeta));
    } else if (isInserting) {
      context.missing(_descMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Tour map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Tour.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $ToursTable createAlias(String alias) {
    return $ToursTable(_db, alias);
  }
}

class TourStop extends DataClass implements Insertable<TourStop> {
  final int id;
  final int id_tour;
  final String id_stop;
  TourStop({@required this.id, @required this.id_tour, @required this.id_stop});
  factory TourStop.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return TourStop(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      id_tour:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}id_tour']),
      id_stop:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}id_stop']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || id_tour != null) {
      map['id_tour'] = Variable<int>(id_tour);
    }
    if (!nullToAbsent || id_stop != null) {
      map['id_stop'] = Variable<String>(id_stop);
    }
    return map;
  }

  factory TourStop.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return TourStop(
      id: serializer.fromJson<int>(json['id']),
      id_tour: serializer.fromJson<int>(json['id_tour']),
      id_stop: serializer.fromJson<String>(json['id_stop']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'id_tour': serializer.toJson<int>(id_tour),
      'id_stop': serializer.toJson<String>(id_stop),
    };
  }

  TourStop copyWith({int id, int id_tour, String id_stop}) => TourStop(
        id: id ?? this.id,
        id_tour: id_tour ?? this.id_tour,
        id_stop: id_stop ?? this.id_stop,
      );
  @override
  String toString() {
    return (StringBuffer('TourStop(')
          ..write('id: $id, ')
          ..write('id_tour: $id_tour, ')
          ..write('id_stop: $id_stop')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(id.hashCode, $mrjc(id_tour.hashCode, id_stop.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is TourStop &&
          other.id == this.id &&
          other.id_tour == this.id_tour &&
          other.id_stop == this.id_stop);
}

class TourStopsCompanion extends UpdateCompanion<TourStop> {
  final Value<int> id;
  final Value<int> id_tour;
  final Value<String> id_stop;
  const TourStopsCompanion({
    this.id = const Value.absent(),
    this.id_tour = const Value.absent(),
    this.id_stop = const Value.absent(),
  });
  TourStopsCompanion.insert({
    @required int id,
    @required int id_tour,
    @required String id_stop,
  })  : id = Value(id),
        id_tour = Value(id_tour),
        id_stop = Value(id_stop);
  static Insertable<TourStop> custom({
    Expression<int> id,
    Expression<int> id_tour,
    Expression<String> id_stop,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (id_tour != null) 'id_tour': id_tour,
      if (id_stop != null) 'id_stop': id_stop,
    });
  }

  TourStopsCompanion copyWith(
      {Value<int> id, Value<int> id_tour, Value<String> id_stop}) {
    return TourStopsCompanion(
      id: id ?? this.id,
      id_tour: id_tour ?? this.id_tour,
      id_stop: id_stop ?? this.id_stop,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (id_tour.present) {
      map['id_tour'] = Variable<int>(id_tour.value);
    }
    if (id_stop.present) {
      map['id_stop'] = Variable<String>(id_stop.value);
    }
    return map;
  }
}

class $TourStopsTable extends TourStops
    with TableInfo<$TourStopsTable, TourStop> {
  final GeneratedDatabase _db;
  final String _alias;
  $TourStopsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _id_tourMeta = const VerificationMeta('id_tour');
  GeneratedIntColumn _id_tour;
  @override
  GeneratedIntColumn get id_tour => _id_tour ??= _constructIdTour();
  GeneratedIntColumn _constructIdTour() {
    return GeneratedIntColumn('id_tour', $tableName, false,
        $customConstraints: 'REFERENCES tours(id)');
  }

  final VerificationMeta _id_stopMeta = const VerificationMeta('id_stop');
  GeneratedTextColumn _id_stop;
  @override
  GeneratedTextColumn get id_stop => _id_stop ??= _constructIdStop();
  GeneratedTextColumn _constructIdStop() {
    return GeneratedTextColumn('id_stop', $tableName, false,
        $customConstraints: 'REFERENCES stops(id)');
  }

  @override
  List<GeneratedColumn> get $columns => [id, id_tour, id_stop];
  @override
  $TourStopsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'tour_stops';
  @override
  final String actualTableName = 'tour_stops';
  @override
  VerificationContext validateIntegrity(Insertable<TourStop> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('id_tour')) {
      context.handle(_id_tourMeta,
          id_tour.isAcceptableOrUnknown(data['id_tour'], _id_tourMeta));
    } else if (isInserting) {
      context.missing(_id_tourMeta);
    }
    if (data.containsKey('id_stop')) {
      context.handle(_id_stopMeta,
          id_stop.isAcceptableOrUnknown(data['id_stop'], _id_stopMeta));
    } else if (isInserting) {
      context.missing(_id_stopMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  TourStop map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return TourStop.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $TourStopsTable createAlias(String alias) {
    return $TourStopsTable(_db, alias);
  }
}

class Extra extends DataClass implements Insertable<Extra> {
  final int pos_extra;
  final int pos_stop;
  final int id_tour;
  final String id_stop;
  final String textInfo;
  final ExtraType type;
  final List<String> answerOpt;
  final List<int> answerCor;
  Extra(
      {@required this.pos_extra,
      @required this.pos_stop,
      @required this.id_tour,
      @required this.id_stop,
      @required this.textInfo,
      this.type,
      this.answerOpt,
      this.answerCor});
  factory Extra.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Extra(
      pos_extra:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}pos_extra']),
      pos_stop:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}pos_stop']),
      id_tour:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}id_tour']),
      id_stop:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}id_stop']),
      textInfo: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}text_info']),
      type: $ExtrasTable.$converter0.mapToDart(
          intType.mapFromDatabaseResponse(data['${effectivePrefix}type'])),
      answerOpt: $ExtrasTable.$converter1.mapToDart(stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}answer_opt'])),
      answerCor: $ExtrasTable.$converter2.mapToDart(stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}answer_cor'])),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || pos_extra != null) {
      map['pos_extra'] = Variable<int>(pos_extra);
    }
    if (!nullToAbsent || pos_stop != null) {
      map['pos_stop'] = Variable<int>(pos_stop);
    }
    if (!nullToAbsent || id_tour != null) {
      map['id_tour'] = Variable<int>(id_tour);
    }
    if (!nullToAbsent || id_stop != null) {
      map['id_stop'] = Variable<String>(id_stop);
    }
    if (!nullToAbsent || textInfo != null) {
      map['text_info'] = Variable<String>(textInfo);
    }
    if (!nullToAbsent || type != null) {
      final converter = $ExtrasTable.$converter0;
      map['type'] = Variable<int>(converter.mapToSql(type));
    }
    if (!nullToAbsent || answerOpt != null) {
      final converter = $ExtrasTable.$converter1;
      map['answer_opt'] = Variable<String>(converter.mapToSql(answerOpt));
    }
    if (!nullToAbsent || answerCor != null) {
      final converter = $ExtrasTable.$converter2;
      map['answer_cor'] = Variable<String>(converter.mapToSql(answerCor));
    }
    return map;
  }

  factory Extra.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Extra(
      pos_extra: serializer.fromJson<int>(json['pos_extra']),
      pos_stop: serializer.fromJson<int>(json['pos_stop']),
      id_tour: serializer.fromJson<int>(json['id_tour']),
      id_stop: serializer.fromJson<String>(json['id_stop']),
      textInfo: serializer.fromJson<String>(json['textInfo']),
      type: serializer.fromJson<ExtraType>(json['type']),
      answerOpt: serializer.fromJson<List<String>>(json['answerOpt']),
      answerCor: serializer.fromJson<List<int>>(json['answerCor']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'pos_extra': serializer.toJson<int>(pos_extra),
      'pos_stop': serializer.toJson<int>(pos_stop),
      'id_tour': serializer.toJson<int>(id_tour),
      'id_stop': serializer.toJson<String>(id_stop),
      'textInfo': serializer.toJson<String>(textInfo),
      'type': serializer.toJson<ExtraType>(type),
      'answerOpt': serializer.toJson<List<String>>(answerOpt),
      'answerCor': serializer.toJson<List<int>>(answerCor),
    };
  }

  Extra copyWith(
          {int pos_extra,
          int pos_stop,
          int id_tour,
          String id_stop,
          String textInfo,
          ExtraType type,
          List<String> answerOpt,
          List<int> answerCor}) =>
      Extra(
        pos_extra: pos_extra ?? this.pos_extra,
        pos_stop: pos_stop ?? this.pos_stop,
        id_tour: id_tour ?? this.id_tour,
        id_stop: id_stop ?? this.id_stop,
        textInfo: textInfo ?? this.textInfo,
        type: type ?? this.type,
        answerOpt: answerOpt ?? this.answerOpt,
        answerCor: answerCor ?? this.answerCor,
      );
  @override
  String toString() {
    return (StringBuffer('Extra(')
          ..write('pos_extra: $pos_extra, ')
          ..write('pos_stop: $pos_stop, ')
          ..write('id_tour: $id_tour, ')
          ..write('id_stop: $id_stop, ')
          ..write('textInfo: $textInfo, ')
          ..write('type: $type, ')
          ..write('answerOpt: $answerOpt, ')
          ..write('answerCor: $answerCor')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      pos_extra.hashCode,
      $mrjc(
          pos_stop.hashCode,
          $mrjc(
              id_tour.hashCode,
              $mrjc(
                  id_stop.hashCode,
                  $mrjc(
                      textInfo.hashCode,
                      $mrjc(type.hashCode,
                          $mrjc(answerOpt.hashCode, answerCor.hashCode))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Extra &&
          other.pos_extra == this.pos_extra &&
          other.pos_stop == this.pos_stop &&
          other.id_tour == this.id_tour &&
          other.id_stop == this.id_stop &&
          other.textInfo == this.textInfo &&
          other.type == this.type &&
          other.answerOpt == this.answerOpt &&
          other.answerCor == this.answerCor);
}

class ExtrasCompanion extends UpdateCompanion<Extra> {
  final Value<int> pos_extra;
  final Value<int> pos_stop;
  final Value<int> id_tour;
  final Value<String> id_stop;
  final Value<String> textInfo;
  final Value<ExtraType> type;
  final Value<List<String>> answerOpt;
  final Value<List<int>> answerCor;
  const ExtrasCompanion({
    this.pos_extra = const Value.absent(),
    this.pos_stop = const Value.absent(),
    this.id_tour = const Value.absent(),
    this.id_stop = const Value.absent(),
    this.textInfo = const Value.absent(),
    this.type = const Value.absent(),
    this.answerOpt = const Value.absent(),
    this.answerCor = const Value.absent(),
  });
  ExtrasCompanion.insert({
    @required int pos_extra,
    @required int pos_stop,
    @required int id_tour,
    @required String id_stop,
    @required String textInfo,
    this.type = const Value.absent(),
    this.answerOpt = const Value.absent(),
    this.answerCor = const Value.absent(),
  })  : pos_extra = Value(pos_extra),
        pos_stop = Value(pos_stop),
        id_tour = Value(id_tour),
        id_stop = Value(id_stop),
        textInfo = Value(textInfo);
  static Insertable<Extra> custom({
    Expression<int> pos_extra,
    Expression<int> pos_stop,
    Expression<int> id_tour,
    Expression<String> id_stop,
    Expression<String> textInfo,
    Expression<int> type,
    Expression<String> answerOpt,
    Expression<String> answerCor,
  }) {
    return RawValuesInsertable({
      if (pos_extra != null) 'pos_extra': pos_extra,
      if (pos_stop != null) 'pos_stop': pos_stop,
      if (id_tour != null) 'id_tour': id_tour,
      if (id_stop != null) 'id_stop': id_stop,
      if (textInfo != null) 'text_info': textInfo,
      if (type != null) 'type': type,
      if (answerOpt != null) 'answer_opt': answerOpt,
      if (answerCor != null) 'answer_cor': answerCor,
    });
  }

  ExtrasCompanion copyWith(
      {Value<int> pos_extra,
      Value<int> pos_stop,
      Value<int> id_tour,
      Value<String> id_stop,
      Value<String> textInfo,
      Value<ExtraType> type,
      Value<List<String>> answerOpt,
      Value<List<int>> answerCor}) {
    return ExtrasCompanion(
      pos_extra: pos_extra ?? this.pos_extra,
      pos_stop: pos_stop ?? this.pos_stop,
      id_tour: id_tour ?? this.id_tour,
      id_stop: id_stop ?? this.id_stop,
      textInfo: textInfo ?? this.textInfo,
      type: type ?? this.type,
      answerOpt: answerOpt ?? this.answerOpt,
      answerCor: answerCor ?? this.answerCor,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (pos_extra.present) {
      map['pos_extra'] = Variable<int>(pos_extra.value);
    }
    if (pos_stop.present) {
      map['pos_stop'] = Variable<int>(pos_stop.value);
    }
    if (id_tour.present) {
      map['id_tour'] = Variable<int>(id_tour.value);
    }
    if (id_stop.present) {
      map['id_stop'] = Variable<String>(id_stop.value);
    }
    if (textInfo.present) {
      map['text_info'] = Variable<String>(textInfo.value);
    }
    if (type.present) {
      final converter = $ExtrasTable.$converter0;
      map['type'] = Variable<int>(converter.mapToSql(type.value));
    }
    if (answerOpt.present) {
      final converter = $ExtrasTable.$converter1;
      map['answer_opt'] = Variable<String>(converter.mapToSql(answerOpt.value));
    }
    if (answerCor.present) {
      final converter = $ExtrasTable.$converter2;
      map['answer_cor'] = Variable<String>(converter.mapToSql(answerCor.value));
    }
    return map;
  }
}

class $ExtrasTable extends Extras with TableInfo<$ExtrasTable, Extra> {
  final GeneratedDatabase _db;
  final String _alias;
  $ExtrasTable(this._db, [this._alias]);
  final VerificationMeta _pos_extraMeta = const VerificationMeta('pos_extra');
  GeneratedIntColumn _pos_extra;
  @override
  GeneratedIntColumn get pos_extra => _pos_extra ??= _constructPosExtra();
  GeneratedIntColumn _constructPosExtra() {
    return GeneratedIntColumn(
      'pos_extra',
      $tableName,
      false,
    );
  }

  final VerificationMeta _pos_stopMeta = const VerificationMeta('pos_stop');
  GeneratedIntColumn _pos_stop;
  @override
  GeneratedIntColumn get pos_stop => _pos_stop ??= _constructPosStop();
  GeneratedIntColumn _constructPosStop() {
    return GeneratedIntColumn(
      'pos_stop',
      $tableName,
      false,
    );
  }

  final VerificationMeta _id_tourMeta = const VerificationMeta('id_tour');
  GeneratedIntColumn _id_tour;
  @override
  GeneratedIntColumn get id_tour => _id_tour ??= _constructIdTour();
  GeneratedIntColumn _constructIdTour() {
    return GeneratedIntColumn('id_tour', $tableName, false,
        $customConstraints: 'REFERENCES tours(id)');
  }

  final VerificationMeta _id_stopMeta = const VerificationMeta('id_stop');
  GeneratedTextColumn _id_stop;
  @override
  GeneratedTextColumn get id_stop => _id_stop ??= _constructIdStop();
  GeneratedTextColumn _constructIdStop() {
    return GeneratedTextColumn('id_stop', $tableName, false,
        $customConstraints: 'REFERENCES stops(id)');
  }

  final VerificationMeta _textInfoMeta = const VerificationMeta('textInfo');
  GeneratedTextColumn _textInfo;
  @override
  GeneratedTextColumn get textInfo => _textInfo ??= _constructTextInfo();
  GeneratedTextColumn _constructTextInfo() {
    return GeneratedTextColumn(
      'text_info',
      $tableName,
      false,
    );
  }

  final VerificationMeta _typeMeta = const VerificationMeta('type');
  GeneratedIntColumn _type;
  @override
  GeneratedIntColumn get type => _type ??= _constructType();
  GeneratedIntColumn _constructType() {
    return GeneratedIntColumn(
      'type',
      $tableName,
      true,
    );
  }

  final VerificationMeta _answerOptMeta = const VerificationMeta('answerOpt');
  GeneratedTextColumn _answerOpt;
  @override
  GeneratedTextColumn get answerOpt => _answerOpt ??= _constructAnswerOpt();
  GeneratedTextColumn _constructAnswerOpt() {
    return GeneratedTextColumn(
      'answer_opt',
      $tableName,
      true,
    );
  }

  final VerificationMeta _answerCorMeta = const VerificationMeta('answerCor');
  GeneratedTextColumn _answerCor;
  @override
  GeneratedTextColumn get answerCor => _answerCor ??= _constructAnswerCor();
  GeneratedTextColumn _constructAnswerCor() {
    return GeneratedTextColumn(
      'answer_cor',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        pos_extra,
        pos_stop,
        id_tour,
        id_stop,
        textInfo,
        type,
        answerOpt,
        answerCor
      ];
  @override
  $ExtrasTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'extras';
  @override
  final String actualTableName = 'extras';
  @override
  VerificationContext validateIntegrity(Insertable<Extra> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('pos_extra')) {
      context.handle(_pos_extraMeta,
          pos_extra.isAcceptableOrUnknown(data['pos_extra'], _pos_extraMeta));
    } else if (isInserting) {
      context.missing(_pos_extraMeta);
    }
    if (data.containsKey('pos_stop')) {
      context.handle(_pos_stopMeta,
          pos_stop.isAcceptableOrUnknown(data['pos_stop'], _pos_stopMeta));
    } else if (isInserting) {
      context.missing(_pos_stopMeta);
    }
    if (data.containsKey('id_tour')) {
      context.handle(_id_tourMeta,
          id_tour.isAcceptableOrUnknown(data['id_tour'], _id_tourMeta));
    } else if (isInserting) {
      context.missing(_id_tourMeta);
    }
    if (data.containsKey('id_stop')) {
      context.handle(_id_stopMeta,
          id_stop.isAcceptableOrUnknown(data['id_stop'], _id_stopMeta));
    } else if (isInserting) {
      context.missing(_id_stopMeta);
    }
    if (data.containsKey('text_info')) {
      context.handle(_textInfoMeta,
          textInfo.isAcceptableOrUnknown(data['text_info'], _textInfoMeta));
    } else if (isInserting) {
      context.missing(_textInfoMeta);
    }
    context.handle(_typeMeta, const VerificationResult.success());
    context.handle(_answerOptMeta, const VerificationResult.success());
    context.handle(_answerCorMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey =>
      {pos_stop, pos_extra, id_tour, id_stop};
  @override
  Extra map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Extra.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $ExtrasTable createAlias(String alias) {
    return $ExtrasTable(_db, alias);
  }

  static TypeConverter<ExtraType, int> $converter0 = TaskTypeConverter();
  static TypeConverter<List<String>, String> $converter1 =
      StringListConverter();
  static TypeConverter<List<int>, String> $converter2 = IntListConverter();
}

class StopFeature extends DataClass implements Insertable<StopFeature> {
  final int id;
  final int id_tour;
  final String id_stop;
  final bool showImages;
  final bool showText;
  final bool showDetails;
  StopFeature(
      {@required this.id,
      @required this.id_tour,
      @required this.id_stop,
      @required this.showImages,
      @required this.showText,
      @required this.showDetails});
  factory StopFeature.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    return StopFeature(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      id_tour:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}id_tour']),
      id_stop:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}id_stop']),
      showImages: boolType
          .mapFromDatabaseResponse(data['${effectivePrefix}show_images']),
      showText:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}show_text']),
      showDetails: boolType
          .mapFromDatabaseResponse(data['${effectivePrefix}show_details']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || id_tour != null) {
      map['id_tour'] = Variable<int>(id_tour);
    }
    if (!nullToAbsent || id_stop != null) {
      map['id_stop'] = Variable<String>(id_stop);
    }
    if (!nullToAbsent || showImages != null) {
      map['show_images'] = Variable<bool>(showImages);
    }
    if (!nullToAbsent || showText != null) {
      map['show_text'] = Variable<bool>(showText);
    }
    if (!nullToAbsent || showDetails != null) {
      map['show_details'] = Variable<bool>(showDetails);
    }
    return map;
  }

  factory StopFeature.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return StopFeature(
      id: serializer.fromJson<int>(json['id']),
      id_tour: serializer.fromJson<int>(json['id_tour']),
      id_stop: serializer.fromJson<String>(json['id_stop']),
      showImages: serializer.fromJson<bool>(json['showImages']),
      showText: serializer.fromJson<bool>(json['showText']),
      showDetails: serializer.fromJson<bool>(json['showDetails']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'id_tour': serializer.toJson<int>(id_tour),
      'id_stop': serializer.toJson<String>(id_stop),
      'showImages': serializer.toJson<bool>(showImages),
      'showText': serializer.toJson<bool>(showText),
      'showDetails': serializer.toJson<bool>(showDetails),
    };
  }

  StopFeature copyWith(
          {int id,
          int id_tour,
          String id_stop,
          bool showImages,
          bool showText,
          bool showDetails}) =>
      StopFeature(
        id: id ?? this.id,
        id_tour: id_tour ?? this.id_tour,
        id_stop: id_stop ?? this.id_stop,
        showImages: showImages ?? this.showImages,
        showText: showText ?? this.showText,
        showDetails: showDetails ?? this.showDetails,
      );
  @override
  String toString() {
    return (StringBuffer('StopFeature(')
          ..write('id: $id, ')
          ..write('id_tour: $id_tour, ')
          ..write('id_stop: $id_stop, ')
          ..write('showImages: $showImages, ')
          ..write('showText: $showText, ')
          ..write('showDetails: $showDetails')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          id_tour.hashCode,
          $mrjc(
              id_stop.hashCode,
              $mrjc(showImages.hashCode,
                  $mrjc(showText.hashCode, showDetails.hashCode))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is StopFeature &&
          other.id == this.id &&
          other.id_tour == this.id_tour &&
          other.id_stop == this.id_stop &&
          other.showImages == this.showImages &&
          other.showText == this.showText &&
          other.showDetails == this.showDetails);
}

class StopFeaturesCompanion extends UpdateCompanion<StopFeature> {
  final Value<int> id;
  final Value<int> id_tour;
  final Value<String> id_stop;
  final Value<bool> showImages;
  final Value<bool> showText;
  final Value<bool> showDetails;
  const StopFeaturesCompanion({
    this.id = const Value.absent(),
    this.id_tour = const Value.absent(),
    this.id_stop = const Value.absent(),
    this.showImages = const Value.absent(),
    this.showText = const Value.absent(),
    this.showDetails = const Value.absent(),
  });
  StopFeaturesCompanion.insert({
    @required int id,
    @required int id_tour,
    @required String id_stop,
    this.showImages = const Value.absent(),
    this.showText = const Value.absent(),
    this.showDetails = const Value.absent(),
  })  : id = Value(id),
        id_tour = Value(id_tour),
        id_stop = Value(id_stop);
  static Insertable<StopFeature> custom({
    Expression<int> id,
    Expression<int> id_tour,
    Expression<String> id_stop,
    Expression<bool> showImages,
    Expression<bool> showText,
    Expression<bool> showDetails,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (id_tour != null) 'id_tour': id_tour,
      if (id_stop != null) 'id_stop': id_stop,
      if (showImages != null) 'show_images': showImages,
      if (showText != null) 'show_text': showText,
      if (showDetails != null) 'show_details': showDetails,
    });
  }

  StopFeaturesCompanion copyWith(
      {Value<int> id,
      Value<int> id_tour,
      Value<String> id_stop,
      Value<bool> showImages,
      Value<bool> showText,
      Value<bool> showDetails}) {
    return StopFeaturesCompanion(
      id: id ?? this.id,
      id_tour: id_tour ?? this.id_tour,
      id_stop: id_stop ?? this.id_stop,
      showImages: showImages ?? this.showImages,
      showText: showText ?? this.showText,
      showDetails: showDetails ?? this.showDetails,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (id_tour.present) {
      map['id_tour'] = Variable<int>(id_tour.value);
    }
    if (id_stop.present) {
      map['id_stop'] = Variable<String>(id_stop.value);
    }
    if (showImages.present) {
      map['show_images'] = Variable<bool>(showImages.value);
    }
    if (showText.present) {
      map['show_text'] = Variable<bool>(showText.value);
    }
    if (showDetails.present) {
      map['show_details'] = Variable<bool>(showDetails.value);
    }
    return map;
  }
}

class $StopFeaturesTable extends StopFeatures
    with TableInfo<$StopFeaturesTable, StopFeature> {
  final GeneratedDatabase _db;
  final String _alias;
  $StopFeaturesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        $customConstraints: 'REFERENCES tourStops(id)');
  }

  final VerificationMeta _id_tourMeta = const VerificationMeta('id_tour');
  GeneratedIntColumn _id_tour;
  @override
  GeneratedIntColumn get id_tour => _id_tour ??= _constructIdTour();
  GeneratedIntColumn _constructIdTour() {
    return GeneratedIntColumn('id_tour', $tableName, false,
        $customConstraints: 'REFERENCES tours(id)');
  }

  final VerificationMeta _id_stopMeta = const VerificationMeta('id_stop');
  GeneratedTextColumn _id_stop;
  @override
  GeneratedTextColumn get id_stop => _id_stop ??= _constructIdStop();
  GeneratedTextColumn _constructIdStop() {
    return GeneratedTextColumn('id_stop', $tableName, false,
        $customConstraints: 'REFERENCES stops(id)');
  }

  final VerificationMeta _showImagesMeta = const VerificationMeta('showImages');
  GeneratedBoolColumn _showImages;
  @override
  GeneratedBoolColumn get showImages => _showImages ??= _constructShowImages();
  GeneratedBoolColumn _constructShowImages() {
    return GeneratedBoolColumn('show_images', $tableName, false,
        defaultValue: const Constant(true));
  }

  final VerificationMeta _showTextMeta = const VerificationMeta('showText');
  GeneratedBoolColumn _showText;
  @override
  GeneratedBoolColumn get showText => _showText ??= _constructShowText();
  GeneratedBoolColumn _constructShowText() {
    return GeneratedBoolColumn('show_text', $tableName, false,
        defaultValue: const Constant(true));
  }

  final VerificationMeta _showDetailsMeta =
      const VerificationMeta('showDetails');
  GeneratedBoolColumn _showDetails;
  @override
  GeneratedBoolColumn get showDetails =>
      _showDetails ??= _constructShowDetails();
  GeneratedBoolColumn _constructShowDetails() {
    return GeneratedBoolColumn('show_details', $tableName, false,
        defaultValue: const Constant(true));
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, id_tour, id_stop, showImages, showText, showDetails];
  @override
  $StopFeaturesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'stop_features';
  @override
  final String actualTableName = 'stop_features';
  @override
  VerificationContext validateIntegrity(Insertable<StopFeature> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('id_tour')) {
      context.handle(_id_tourMeta,
          id_tour.isAcceptableOrUnknown(data['id_tour'], _id_tourMeta));
    } else if (isInserting) {
      context.missing(_id_tourMeta);
    }
    if (data.containsKey('id_stop')) {
      context.handle(_id_stopMeta,
          id_stop.isAcceptableOrUnknown(data['id_stop'], _id_stopMeta));
    } else if (isInserting) {
      context.missing(_id_stopMeta);
    }
    if (data.containsKey('show_images')) {
      context.handle(
          _showImagesMeta,
          showImages.isAcceptableOrUnknown(
              data['show_images'], _showImagesMeta));
    }
    if (data.containsKey('show_text')) {
      context.handle(_showTextMeta,
          showText.isAcceptableOrUnknown(data['show_text'], _showTextMeta));
    }
    if (data.containsKey('show_details')) {
      context.handle(
          _showDetailsMeta,
          showDetails.isAcceptableOrUnknown(
              data['show_details'], _showDetailsMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id, id_tour, id_stop};
  @override
  StopFeature map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return StopFeature.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $StopFeaturesTable createAlias(String alias) {
    return $StopFeaturesTable(_db, alias);
  }
}

abstract class _$MuseumDatabase extends GeneratedDatabase {
  _$MuseumDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $UsersTable _users;
  $UsersTable get users => _users ??= $UsersTable(this);
  $BadgesTable _badges;
  $BadgesTable get badges => _badges ??= $BadgesTable(this);
  $StopsTable _stops;
  $StopsTable get stops => _stops ??= $StopsTable(this);
  $DivisionsTable _divisions;
  $DivisionsTable get divisions => _divisions ??= $DivisionsTable(this);
  $ToursTable _tours;
  $ToursTable get tours => _tours ??= $ToursTable(this);
  $TourStopsTable _tourStops;
  $TourStopsTable get tourStops => _tourStops ??= $TourStopsTable(this);
  $ExtrasTable _extras;
  $ExtrasTable get extras => _extras ??= $ExtrasTable(this);
  $StopFeaturesTable _stopFeatures;
  $StopFeaturesTable get stopFeatures =>
      _stopFeatures ??= $StopFeaturesTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [users, badges, stops, divisions, tours, tourStops, extras, stopFeatures];
}
