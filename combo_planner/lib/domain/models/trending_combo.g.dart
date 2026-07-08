// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trending_combo.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTrendingComboCollection on Isar {
  IsarCollection<TrendingCombo> get trendingCombos => this.collection();
}

const TrendingComboSchema = CollectionSchema(
  name: r'TrendingCombo',
  id: -1676138546029693419,
  properties: {
    r'acceptedCount': PropertySchema(
      id: 0,
      name: r'acceptedCount',
      type: IsarType.long,
    ),
    r'items': PropertySchema(
      id: 1,
      name: r'items',
      type: IsarType.stringList,
    ),
    r'label': PropertySchema(
      id: 2,
      name: r'label',
      type: IsarType.string,
    ),
    r'mallId': PropertySchema(
      id: 3,
      name: r'mallId',
      type: IsarType.string,
    ),
    r'timestamp': PropertySchema(
      id: 4,
      name: r'timestamp',
      type: IsarType.dateTime,
    ),
    r'totalPrice': PropertySchema(
      id: 5,
      name: r'totalPrice',
      type: IsarType.double,
    )
  },
  estimateSize: _trendingComboEstimateSize,
  serialize: _trendingComboSerialize,
  deserialize: _trendingComboDeserialize,
  deserializeProp: _trendingComboDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _trendingComboGetId,
  getLinks: _trendingComboGetLinks,
  attach: _trendingComboAttach,
  version: '3.1.0+1',
);

int _trendingComboEstimateSize(
  TrendingCombo object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.items.length * 3;
  {
    for (var i = 0; i < object.items.length; i++) {
      final value = object.items[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.label.length * 3;
  bytesCount += 3 + object.mallId.length * 3;
  return bytesCount;
}

void _trendingComboSerialize(
  TrendingCombo object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.acceptedCount);
  writer.writeStringList(offsets[1], object.items);
  writer.writeString(offsets[2], object.label);
  writer.writeString(offsets[3], object.mallId);
  writer.writeDateTime(offsets[4], object.timestamp);
  writer.writeDouble(offsets[5], object.totalPrice);
}

TrendingCombo _trendingComboDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TrendingCombo();
  object.acceptedCount = reader.readLong(offsets[0]);
  object.id = id;
  object.items = reader.readStringList(offsets[1]) ?? [];
  object.label = reader.readString(offsets[2]);
  object.mallId = reader.readString(offsets[3]);
  object.timestamp = reader.readDateTime(offsets[4]);
  object.totalPrice = reader.readDouble(offsets[5]);
  return object;
}

P _trendingComboDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readStringList(offset) ?? []) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readDateTime(offset)) as P;
    case 5:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _trendingComboGetId(TrendingCombo object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _trendingComboGetLinks(TrendingCombo object) {
  return [];
}

void _trendingComboAttach(
    IsarCollection<dynamic> col, Id id, TrendingCombo object) {
  object.id = id;
}

extension TrendingComboQueryWhereSort
    on QueryBuilder<TrendingCombo, TrendingCombo, QWhere> {
  QueryBuilder<TrendingCombo, TrendingCombo, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension TrendingComboQueryWhere
    on QueryBuilder<TrendingCombo, TrendingCombo, QWhereClause> {
  QueryBuilder<TrendingCombo, TrendingCombo, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterWhereClause> idBetween(
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
}

extension TrendingComboQueryFilter
    on QueryBuilder<TrendingCombo, TrendingCombo, QFilterCondition> {
  QueryBuilder<TrendingCombo, TrendingCombo, QAfterFilterCondition>
      acceptedCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'acceptedCount',
        value: value,
      ));
    });
  }

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterFilterCondition>
      acceptedCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'acceptedCount',
        value: value,
      ));
    });
  }

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterFilterCondition>
      acceptedCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'acceptedCount',
        value: value,
      ));
    });
  }

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterFilterCondition>
      acceptedCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'acceptedCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterFilterCondition> idBetween(
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

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterFilterCondition>
      itemsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'items',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterFilterCondition>
      itemsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'items',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterFilterCondition>
      itemsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'items',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterFilterCondition>
      itemsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'items',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterFilterCondition>
      itemsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'items',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterFilterCondition>
      itemsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'items',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterFilterCondition>
      itemsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'items',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterFilterCondition>
      itemsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'items',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterFilterCondition>
      itemsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'items',
        value: '',
      ));
    });
  }

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterFilterCondition>
      itemsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'items',
        value: '',
      ));
    });
  }

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterFilterCondition>
      itemsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'items',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterFilterCondition>
      itemsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'items',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterFilterCondition>
      itemsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'items',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterFilterCondition>
      itemsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'items',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterFilterCondition>
      itemsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'items',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterFilterCondition>
      itemsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'items',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterFilterCondition>
      labelEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterFilterCondition>
      labelGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterFilterCondition>
      labelLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterFilterCondition>
      labelBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'label',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterFilterCondition>
      labelStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterFilterCondition>
      labelEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterFilterCondition>
      labelContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterFilterCondition>
      labelMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'label',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterFilterCondition>
      labelIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'label',
        value: '',
      ));
    });
  }

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterFilterCondition>
      labelIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'label',
        value: '',
      ));
    });
  }

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterFilterCondition>
      mallIdEqualTo(
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

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterFilterCondition>
      mallIdGreaterThan(
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

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterFilterCondition>
      mallIdLessThan(
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

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterFilterCondition>
      mallIdBetween(
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

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterFilterCondition>
      mallIdStartsWith(
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

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterFilterCondition>
      mallIdEndsWith(
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

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterFilterCondition>
      mallIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'mallId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterFilterCondition>
      mallIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'mallId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterFilterCondition>
      mallIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mallId',
        value: '',
      ));
    });
  }

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterFilterCondition>
      mallIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mallId',
        value: '',
      ));
    });
  }

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterFilterCondition>
      timestampEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterFilterCondition>
      timestampGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterFilterCondition>
      timestampLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterFilterCondition>
      timestampBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timestamp',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterFilterCondition>
      totalPriceEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterFilterCondition>
      totalPriceGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterFilterCondition>
      totalPriceLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterFilterCondition>
      totalPriceBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalPrice',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension TrendingComboQueryObject
    on QueryBuilder<TrendingCombo, TrendingCombo, QFilterCondition> {}

extension TrendingComboQueryLinks
    on QueryBuilder<TrendingCombo, TrendingCombo, QFilterCondition> {}

extension TrendingComboQuerySortBy
    on QueryBuilder<TrendingCombo, TrendingCombo, QSortBy> {
  QueryBuilder<TrendingCombo, TrendingCombo, QAfterSortBy>
      sortByAcceptedCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'acceptedCount', Sort.asc);
    });
  }

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterSortBy>
      sortByAcceptedCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'acceptedCount', Sort.desc);
    });
  }

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterSortBy> sortByLabel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'label', Sort.asc);
    });
  }

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterSortBy> sortByLabelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'label', Sort.desc);
    });
  }

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterSortBy> sortByMallId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mallId', Sort.asc);
    });
  }

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterSortBy> sortByMallIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mallId', Sort.desc);
    });
  }

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterSortBy> sortByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterSortBy>
      sortByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterSortBy> sortByTotalPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalPrice', Sort.asc);
    });
  }

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterSortBy>
      sortByTotalPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalPrice', Sort.desc);
    });
  }
}

extension TrendingComboQuerySortThenBy
    on QueryBuilder<TrendingCombo, TrendingCombo, QSortThenBy> {
  QueryBuilder<TrendingCombo, TrendingCombo, QAfterSortBy>
      thenByAcceptedCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'acceptedCount', Sort.asc);
    });
  }

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterSortBy>
      thenByAcceptedCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'acceptedCount', Sort.desc);
    });
  }

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterSortBy> thenByLabel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'label', Sort.asc);
    });
  }

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterSortBy> thenByLabelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'label', Sort.desc);
    });
  }

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterSortBy> thenByMallId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mallId', Sort.asc);
    });
  }

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterSortBy> thenByMallIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mallId', Sort.desc);
    });
  }

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterSortBy> thenByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterSortBy>
      thenByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterSortBy> thenByTotalPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalPrice', Sort.asc);
    });
  }

  QueryBuilder<TrendingCombo, TrendingCombo, QAfterSortBy>
      thenByTotalPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalPrice', Sort.desc);
    });
  }
}

extension TrendingComboQueryWhereDistinct
    on QueryBuilder<TrendingCombo, TrendingCombo, QDistinct> {
  QueryBuilder<TrendingCombo, TrendingCombo, QDistinct>
      distinctByAcceptedCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'acceptedCount');
    });
  }

  QueryBuilder<TrendingCombo, TrendingCombo, QDistinct> distinctByItems() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'items');
    });
  }

  QueryBuilder<TrendingCombo, TrendingCombo, QDistinct> distinctByLabel(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'label', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TrendingCombo, TrendingCombo, QDistinct> distinctByMallId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mallId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TrendingCombo, TrendingCombo, QDistinct> distinctByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timestamp');
    });
  }

  QueryBuilder<TrendingCombo, TrendingCombo, QDistinct> distinctByTotalPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalPrice');
    });
  }
}

extension TrendingComboQueryProperty
    on QueryBuilder<TrendingCombo, TrendingCombo, QQueryProperty> {
  QueryBuilder<TrendingCombo, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<TrendingCombo, int, QQueryOperations> acceptedCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'acceptedCount');
    });
  }

  QueryBuilder<TrendingCombo, List<String>, QQueryOperations> itemsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'items');
    });
  }

  QueryBuilder<TrendingCombo, String, QQueryOperations> labelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'label');
    });
  }

  QueryBuilder<TrendingCombo, String, QQueryOperations> mallIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mallId');
    });
  }

  QueryBuilder<TrendingCombo, DateTime, QQueryOperations> timestampProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timestamp');
    });
  }

  QueryBuilder<TrendingCombo, double, QQueryOperations> totalPriceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalPrice');
    });
  }
}
