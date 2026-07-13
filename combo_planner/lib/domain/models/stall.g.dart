// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stall.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetStallCollection on Isar {
  IsarCollection<Stall> get stalls => this.collection();
}

const StallSchema = CollectionSchema(
  name: r'Stall',
  id: 6624784353014330488,
  properties: {
    r'cuisineType': PropertySchema(
      id: 0,
      name: r'cuisineType',
      type: IsarType.string,
    ),
    r'isPureVeg': PropertySchema(
      id: 1,
      name: r'isPureVeg',
      type: IsarType.bool,
    ),
    r'mallId': PropertySchema(
      id: 2,
      name: r'mallId',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 3,
      name: r'name',
      type: IsarType.string,
    ),
    r'packagingCharge': PropertySchema(
      id: 4,
      name: r'packagingCharge',
      type: IsarType.double,
    ),
    r'stallId': PropertySchema(
      id: 5,
      name: r'stallId',
      type: IsarType.string,
    )
  },
  estimateSize: _stallEstimateSize,
  serialize: _stallSerialize,
  deserialize: _stallDeserialize,
  deserializeProp: _stallDeserializeProp,
  idName: r'id',
  indexes: {
    r'stallId': IndexSchema(
      id: -2357418786837170693,
      name: r'stallId',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'stallId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _stallGetId,
  getLinks: _stallGetLinks,
  attach: _stallAttach,
  version: '3.1.0+1',
);

int _stallEstimateSize(
  Stall object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.cuisineType.length * 3;
  bytesCount += 3 + object.mallId.length * 3;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.stallId.length * 3;
  return bytesCount;
}

void _stallSerialize(
  Stall object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.cuisineType);
  writer.writeBool(offsets[1], object.isPureVeg);
  writer.writeString(offsets[2], object.mallId);
  writer.writeString(offsets[3], object.name);
  writer.writeDouble(offsets[4], object.packagingCharge);
  writer.writeString(offsets[5], object.stallId);
}

Stall _stallDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Stall();
  object.cuisineType = reader.readString(offsets[0]);
  object.id = id;
  object.isPureVeg = reader.readBool(offsets[1]);
  object.mallId = reader.readString(offsets[2]);
  object.name = reader.readString(offsets[3]);
  object.packagingCharge = reader.readDouble(offsets[4]);
  object.stallId = reader.readString(offsets[5]);
  return object;
}

P _stallDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readDouble(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _stallGetId(Stall object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _stallGetLinks(Stall object) {
  return [];
}

void _stallAttach(IsarCollection<dynamic> col, Id id, Stall object) {
  object.id = id;
}

extension StallByIndex on IsarCollection<Stall> {
  Future<Stall?> getByStallId(String stallId) {
    return getByIndex(r'stallId', [stallId]);
  }

  Stall? getByStallIdSync(String stallId) {
    return getByIndexSync(r'stallId', [stallId]);
  }

  Future<bool> deleteByStallId(String stallId) {
    return deleteByIndex(r'stallId', [stallId]);
  }

  bool deleteByStallIdSync(String stallId) {
    return deleteByIndexSync(r'stallId', [stallId]);
  }

  Future<List<Stall?>> getAllByStallId(List<String> stallIdValues) {
    final values = stallIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'stallId', values);
  }

  List<Stall?> getAllByStallIdSync(List<String> stallIdValues) {
    final values = stallIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'stallId', values);
  }

  Future<int> deleteAllByStallId(List<String> stallIdValues) {
    final values = stallIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'stallId', values);
  }

  int deleteAllByStallIdSync(List<String> stallIdValues) {
    final values = stallIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'stallId', values);
  }

  Future<Id> putByStallId(Stall object) {
    return putByIndex(r'stallId', object);
  }

  Id putByStallIdSync(Stall object, {bool saveLinks = true}) {
    return putByIndexSync(r'stallId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByStallId(List<Stall> objects) {
    return putAllByIndex(r'stallId', objects);
  }

  List<Id> putAllByStallIdSync(List<Stall> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'stallId', objects, saveLinks: saveLinks);
  }
}

extension StallQueryWhereSort on QueryBuilder<Stall, Stall, QWhere> {
  QueryBuilder<Stall, Stall, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension StallQueryWhere on QueryBuilder<Stall, Stall, QWhereClause> {
  QueryBuilder<Stall, Stall, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Stall, Stall, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Stall, Stall, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Stall, Stall, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Stall, Stall, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Stall, Stall, QAfterWhereClause> stallIdEqualTo(String stallId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'stallId',
        value: [stallId],
      ));
    });
  }

  QueryBuilder<Stall, Stall, QAfterWhereClause> stallIdNotEqualTo(
      String stallId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'stallId',
              lower: [],
              upper: [stallId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'stallId',
              lower: [stallId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'stallId',
              lower: [stallId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'stallId',
              lower: [],
              upper: [stallId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension StallQueryFilter on QueryBuilder<Stall, Stall, QFilterCondition> {
  QueryBuilder<Stall, Stall, QAfterFilterCondition> cuisineTypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cuisineType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stall, Stall, QAfterFilterCondition> cuisineTypeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cuisineType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stall, Stall, QAfterFilterCondition> cuisineTypeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cuisineType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stall, Stall, QAfterFilterCondition> cuisineTypeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cuisineType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stall, Stall, QAfterFilterCondition> cuisineTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'cuisineType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stall, Stall, QAfterFilterCondition> cuisineTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'cuisineType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stall, Stall, QAfterFilterCondition> cuisineTypeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'cuisineType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stall, Stall, QAfterFilterCondition> cuisineTypeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'cuisineType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stall, Stall, QAfterFilterCondition> cuisineTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cuisineType',
        value: '',
      ));
    });
  }

  QueryBuilder<Stall, Stall, QAfterFilterCondition> cuisineTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'cuisineType',
        value: '',
      ));
    });
  }

  QueryBuilder<Stall, Stall, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Stall, Stall, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Stall, Stall, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Stall, Stall, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Stall, Stall, QAfterFilterCondition> isPureVegEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isPureVeg',
        value: value,
      ));
    });
  }

  QueryBuilder<Stall, Stall, QAfterFilterCondition> mallIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mallId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stall, Stall, QAfterFilterCondition> mallIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mallId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stall, Stall, QAfterFilterCondition> mallIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mallId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stall, Stall, QAfterFilterCondition> mallIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mallId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stall, Stall, QAfterFilterCondition> mallIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'mallId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stall, Stall, QAfterFilterCondition> mallIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'mallId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stall, Stall, QAfterFilterCondition> mallIdContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'mallId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stall, Stall, QAfterFilterCondition> mallIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'mallId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stall, Stall, QAfterFilterCondition> mallIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mallId',
        value: '',
      ));
    });
  }

  QueryBuilder<Stall, Stall, QAfterFilterCondition> mallIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mallId',
        value: '',
      ));
    });
  }

  QueryBuilder<Stall, Stall, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stall, Stall, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stall, Stall, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stall, Stall, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stall, Stall, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stall, Stall, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stall, Stall, QAfterFilterCondition> nameContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stall, Stall, QAfterFilterCondition> nameMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stall, Stall, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Stall, Stall, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Stall, Stall, QAfterFilterCondition> packagingChargeEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'packagingCharge',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Stall, Stall, QAfterFilterCondition> packagingChargeGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'packagingCharge',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Stall, Stall, QAfterFilterCondition> packagingChargeLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'packagingCharge',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Stall, Stall, QAfterFilterCondition> packagingChargeBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'packagingCharge',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Stall, Stall, QAfterFilterCondition> stallIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stallId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stall, Stall, QAfterFilterCondition> stallIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'stallId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stall, Stall, QAfterFilterCondition> stallIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'stallId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stall, Stall, QAfterFilterCondition> stallIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'stallId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stall, Stall, QAfterFilterCondition> stallIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'stallId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stall, Stall, QAfterFilterCondition> stallIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'stallId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stall, Stall, QAfterFilterCondition> stallIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'stallId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stall, Stall, QAfterFilterCondition> stallIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'stallId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stall, Stall, QAfterFilterCondition> stallIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stallId',
        value: '',
      ));
    });
  }

  QueryBuilder<Stall, Stall, QAfterFilterCondition> stallIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'stallId',
        value: '',
      ));
    });
  }
}

extension StallQueryObject on QueryBuilder<Stall, Stall, QFilterCondition> {}

extension StallQueryLinks on QueryBuilder<Stall, Stall, QFilterCondition> {}

extension StallQuerySortBy on QueryBuilder<Stall, Stall, QSortBy> {
  QueryBuilder<Stall, Stall, QAfterSortBy> sortByCuisineType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cuisineType', Sort.asc);
    });
  }

  QueryBuilder<Stall, Stall, QAfterSortBy> sortByCuisineTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cuisineType', Sort.desc);
    });
  }

  QueryBuilder<Stall, Stall, QAfterSortBy> sortByIsPureVeg() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPureVeg', Sort.asc);
    });
  }

  QueryBuilder<Stall, Stall, QAfterSortBy> sortByIsPureVegDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPureVeg', Sort.desc);
    });
  }

  QueryBuilder<Stall, Stall, QAfterSortBy> sortByMallId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mallId', Sort.asc);
    });
  }

  QueryBuilder<Stall, Stall, QAfterSortBy> sortByMallIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mallId', Sort.desc);
    });
  }

  QueryBuilder<Stall, Stall, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Stall, Stall, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Stall, Stall, QAfterSortBy> sortByPackagingCharge() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'packagingCharge', Sort.asc);
    });
  }

  QueryBuilder<Stall, Stall, QAfterSortBy> sortByPackagingChargeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'packagingCharge', Sort.desc);
    });
  }

  QueryBuilder<Stall, Stall, QAfterSortBy> sortByStallId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stallId', Sort.asc);
    });
  }

  QueryBuilder<Stall, Stall, QAfterSortBy> sortByStallIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stallId', Sort.desc);
    });
  }
}

extension StallQuerySortThenBy on QueryBuilder<Stall, Stall, QSortThenBy> {
  QueryBuilder<Stall, Stall, QAfterSortBy> thenByCuisineType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cuisineType', Sort.asc);
    });
  }

  QueryBuilder<Stall, Stall, QAfterSortBy> thenByCuisineTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cuisineType', Sort.desc);
    });
  }

  QueryBuilder<Stall, Stall, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Stall, Stall, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Stall, Stall, QAfterSortBy> thenByIsPureVeg() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPureVeg', Sort.asc);
    });
  }

  QueryBuilder<Stall, Stall, QAfterSortBy> thenByIsPureVegDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPureVeg', Sort.desc);
    });
  }

  QueryBuilder<Stall, Stall, QAfterSortBy> thenByMallId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mallId', Sort.asc);
    });
  }

  QueryBuilder<Stall, Stall, QAfterSortBy> thenByMallIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mallId', Sort.desc);
    });
  }

  QueryBuilder<Stall, Stall, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Stall, Stall, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Stall, Stall, QAfterSortBy> thenByPackagingCharge() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'packagingCharge', Sort.asc);
    });
  }

  QueryBuilder<Stall, Stall, QAfterSortBy> thenByPackagingChargeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'packagingCharge', Sort.desc);
    });
  }

  QueryBuilder<Stall, Stall, QAfterSortBy> thenByStallId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stallId', Sort.asc);
    });
  }

  QueryBuilder<Stall, Stall, QAfterSortBy> thenByStallIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stallId', Sort.desc);
    });
  }
}

extension StallQueryWhereDistinct on QueryBuilder<Stall, Stall, QDistinct> {
  QueryBuilder<Stall, Stall, QDistinct> distinctByCuisineType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cuisineType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Stall, Stall, QDistinct> distinctByIsPureVeg() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isPureVeg');
    });
  }

  QueryBuilder<Stall, Stall, QDistinct> distinctByMallId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mallId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Stall, Stall, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Stall, Stall, QDistinct> distinctByPackagingCharge() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'packagingCharge');
    });
  }

  QueryBuilder<Stall, Stall, QDistinct> distinctByStallId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'stallId', caseSensitive: caseSensitive);
    });
  }
}

extension StallQueryProperty on QueryBuilder<Stall, Stall, QQueryProperty> {
  QueryBuilder<Stall, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Stall, String, QQueryOperations> cuisineTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cuisineType');
    });
  }

  QueryBuilder<Stall, bool, QQueryOperations> isPureVegProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isPureVeg');
    });
  }

  QueryBuilder<Stall, String, QQueryOperations> mallIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mallId');
    });
  }

  QueryBuilder<Stall, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<Stall, double, QQueryOperations> packagingChargeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'packagingCharge');
    });
  }

  QueryBuilder<Stall, String, QQueryOperations> stallIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'stallId');
    });
  }
}
