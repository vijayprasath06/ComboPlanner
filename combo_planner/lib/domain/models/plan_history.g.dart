// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan_history.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPlanHistoryCollection on Isar {
  IsarCollection<PlanHistory> get planHistorys => this.collection();
}

const PlanHistorySchema = CollectionSchema(
  name: r'PlanHistory',
  id: -3027958147735998684,
  properties: {
    r'itemNames': PropertySchema(
      id: 0,
      name: r'itemNames',
      type: IsarType.stringList,
    ),
    r'mallId': PropertySchema(
      id: 1,
      name: r'mallId',
      type: IsarType.string,
    ),
    r'mallName': PropertySchema(
      id: 2,
      name: r'mallName',
      type: IsarType.string,
    ),
    r'peopleCount': PropertySchema(
      id: 3,
      name: r'peopleCount',
      type: IsarType.long,
    ),
    r'savedAt': PropertySchema(
      id: 4,
      name: r'savedAt',
      type: IsarType.dateTime,
    ),
    r'shareText': PropertySchema(
      id: 5,
      name: r'shareText',
      type: IsarType.string,
    ),
    r'stallsUsed': PropertySchema(
      id: 6,
      name: r'stallsUsed',
      type: IsarType.stringList,
    ),
    r'strategyName': PropertySchema(
      id: 7,
      name: r'strategyName',
      type: IsarType.string,
    ),
    r'totalCost': PropertySchema(
      id: 8,
      name: r'totalCost',
      type: IsarType.double,
    )
  },
  estimateSize: _planHistoryEstimateSize,
  serialize: _planHistorySerialize,
  deserialize: _planHistoryDeserialize,
  deserializeProp: _planHistoryDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _planHistoryGetId,
  getLinks: _planHistoryGetLinks,
  attach: _planHistoryAttach,
  version: '3.1.0+1',
);

int _planHistoryEstimateSize(
  PlanHistory object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.itemNames.length * 3;
  {
    for (var i = 0; i < object.itemNames.length; i++) {
      final value = object.itemNames[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.mallId.length * 3;
  bytesCount += 3 + object.mallName.length * 3;
  bytesCount += 3 + object.shareText.length * 3;
  bytesCount += 3 + object.stallsUsed.length * 3;
  {
    for (var i = 0; i < object.stallsUsed.length; i++) {
      final value = object.stallsUsed[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.strategyName.length * 3;
  return bytesCount;
}

void _planHistorySerialize(
  PlanHistory object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeStringList(offsets[0], object.itemNames);
  writer.writeString(offsets[1], object.mallId);
  writer.writeString(offsets[2], object.mallName);
  writer.writeLong(offsets[3], object.peopleCount);
  writer.writeDateTime(offsets[4], object.savedAt);
  writer.writeString(offsets[5], object.shareText);
  writer.writeStringList(offsets[6], object.stallsUsed);
  writer.writeString(offsets[7], object.strategyName);
  writer.writeDouble(offsets[8], object.totalCost);
}

PlanHistory _planHistoryDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PlanHistory();
  object.id = id;
  object.itemNames = reader.readStringList(offsets[0]) ?? [];
  object.mallId = reader.readString(offsets[1]);
  object.mallName = reader.readString(offsets[2]);
  object.peopleCount = reader.readLong(offsets[3]);
  object.savedAt = reader.readDateTime(offsets[4]);
  object.shareText = reader.readString(offsets[5]);
  object.stallsUsed = reader.readStringList(offsets[6]) ?? [];
  object.strategyName = reader.readString(offsets[7]);
  object.totalCost = reader.readDouble(offsets[8]);
  return object;
}

P _planHistoryDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringList(offset) ?? []) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readDateTime(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readStringList(offset) ?? []) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _planHistoryGetId(PlanHistory object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _planHistoryGetLinks(PlanHistory object) {
  return [];
}

void _planHistoryAttach(
    IsarCollection<dynamic> col, Id id, PlanHistory object) {
  object.id = id;
}

extension PlanHistoryQueryWhereSort
    on QueryBuilder<PlanHistory, PlanHistory, QWhere> {
  QueryBuilder<PlanHistory, PlanHistory, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension PlanHistoryQueryWhere
    on QueryBuilder<PlanHistory, PlanHistory, QWhereClause> {
  QueryBuilder<PlanHistory, PlanHistory, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<PlanHistory, PlanHistory, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterWhereClause> idBetween(
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

extension PlanHistoryQueryFilter
    on QueryBuilder<PlanHistory, PlanHistory, QFilterCondition> {
  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition> idBetween(
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

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition>
      itemNamesElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'itemNames',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition>
      itemNamesElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'itemNames',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition>
      itemNamesElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'itemNames',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition>
      itemNamesElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'itemNames',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition>
      itemNamesElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'itemNames',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition>
      itemNamesElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'itemNames',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition>
      itemNamesElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'itemNames',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition>
      itemNamesElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'itemNames',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition>
      itemNamesElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'itemNames',
        value: '',
      ));
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition>
      itemNamesElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'itemNames',
        value: '',
      ));
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition>
      itemNamesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'itemNames',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition>
      itemNamesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'itemNames',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition>
      itemNamesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'itemNames',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition>
      itemNamesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'itemNames',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition>
      itemNamesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'itemNames',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition>
      itemNamesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'itemNames',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition> mallIdEqualTo(
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

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition>
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

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition> mallIdLessThan(
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

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition> mallIdBetween(
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

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition>
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

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition> mallIdEndsWith(
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

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition> mallIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'mallId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition> mallIdMatches(
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

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition>
      mallIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mallId',
        value: '',
      ));
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition>
      mallIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mallId',
        value: '',
      ));
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition> mallNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mallName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition>
      mallNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mallName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition>
      mallNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mallName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition> mallNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mallName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition>
      mallNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'mallName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition>
      mallNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'mallName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition>
      mallNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'mallName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition> mallNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'mallName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition>
      mallNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mallName',
        value: '',
      ));
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition>
      mallNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mallName',
        value: '',
      ));
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition>
      peopleCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'peopleCount',
        value: value,
      ));
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition>
      peopleCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'peopleCount',
        value: value,
      ));
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition>
      peopleCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'peopleCount',
        value: value,
      ));
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition>
      peopleCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'peopleCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition> savedAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'savedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition>
      savedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'savedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition> savedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'savedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition> savedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'savedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition>
      shareTextEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shareText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition>
      shareTextGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'shareText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition>
      shareTextLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'shareText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition>
      shareTextBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'shareText',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition>
      shareTextStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'shareText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition>
      shareTextEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'shareText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition>
      shareTextContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'shareText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition>
      shareTextMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'shareText',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition>
      shareTextIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shareText',
        value: '',
      ));
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition>
      shareTextIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'shareText',
        value: '',
      ));
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition>
      stallsUsedElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stallsUsed',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition>
      stallsUsedElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'stallsUsed',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition>
      stallsUsedElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'stallsUsed',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition>
      stallsUsedElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'stallsUsed',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition>
      stallsUsedElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'stallsUsed',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition>
      stallsUsedElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'stallsUsed',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition>
      stallsUsedElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'stallsUsed',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition>
      stallsUsedElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'stallsUsed',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition>
      stallsUsedElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stallsUsed',
        value: '',
      ));
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition>
      stallsUsedElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'stallsUsed',
        value: '',
      ));
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition>
      stallsUsedLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'stallsUsed',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition>
      stallsUsedIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'stallsUsed',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition>
      stallsUsedIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'stallsUsed',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition>
      stallsUsedLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'stallsUsed',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition>
      stallsUsedLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'stallsUsed',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition>
      stallsUsedLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'stallsUsed',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition>
      strategyNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'strategyName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition>
      strategyNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'strategyName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition>
      strategyNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'strategyName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition>
      strategyNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'strategyName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition>
      strategyNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'strategyName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition>
      strategyNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'strategyName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition>
      strategyNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'strategyName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition>
      strategyNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'strategyName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition>
      strategyNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'strategyName',
        value: '',
      ));
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition>
      strategyNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'strategyName',
        value: '',
      ));
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition>
      totalCostEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalCost',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition>
      totalCostGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalCost',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition>
      totalCostLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalCost',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterFilterCondition>
      totalCostBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalCost',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension PlanHistoryQueryObject
    on QueryBuilder<PlanHistory, PlanHistory, QFilterCondition> {}

extension PlanHistoryQueryLinks
    on QueryBuilder<PlanHistory, PlanHistory, QFilterCondition> {}

extension PlanHistoryQuerySortBy
    on QueryBuilder<PlanHistory, PlanHistory, QSortBy> {
  QueryBuilder<PlanHistory, PlanHistory, QAfterSortBy> sortByMallId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mallId', Sort.asc);
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterSortBy> sortByMallIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mallId', Sort.desc);
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterSortBy> sortByMallName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mallName', Sort.asc);
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterSortBy> sortByMallNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mallName', Sort.desc);
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterSortBy> sortByPeopleCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'peopleCount', Sort.asc);
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterSortBy> sortByPeopleCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'peopleCount', Sort.desc);
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterSortBy> sortBySavedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'savedAt', Sort.asc);
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterSortBy> sortBySavedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'savedAt', Sort.desc);
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterSortBy> sortByShareText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shareText', Sort.asc);
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterSortBy> sortByShareTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shareText', Sort.desc);
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterSortBy> sortByStrategyName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'strategyName', Sort.asc);
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterSortBy>
      sortByStrategyNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'strategyName', Sort.desc);
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterSortBy> sortByTotalCost() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalCost', Sort.asc);
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterSortBy> sortByTotalCostDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalCost', Sort.desc);
    });
  }
}

extension PlanHistoryQuerySortThenBy
    on QueryBuilder<PlanHistory, PlanHistory, QSortThenBy> {
  QueryBuilder<PlanHistory, PlanHistory, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterSortBy> thenByMallId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mallId', Sort.asc);
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterSortBy> thenByMallIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mallId', Sort.desc);
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterSortBy> thenByMallName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mallName', Sort.asc);
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterSortBy> thenByMallNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mallName', Sort.desc);
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterSortBy> thenByPeopleCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'peopleCount', Sort.asc);
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterSortBy> thenByPeopleCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'peopleCount', Sort.desc);
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterSortBy> thenBySavedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'savedAt', Sort.asc);
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterSortBy> thenBySavedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'savedAt', Sort.desc);
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterSortBy> thenByShareText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shareText', Sort.asc);
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterSortBy> thenByShareTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shareText', Sort.desc);
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterSortBy> thenByStrategyName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'strategyName', Sort.asc);
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterSortBy>
      thenByStrategyNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'strategyName', Sort.desc);
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterSortBy> thenByTotalCost() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalCost', Sort.asc);
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QAfterSortBy> thenByTotalCostDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalCost', Sort.desc);
    });
  }
}

extension PlanHistoryQueryWhereDistinct
    on QueryBuilder<PlanHistory, PlanHistory, QDistinct> {
  QueryBuilder<PlanHistory, PlanHistory, QDistinct> distinctByItemNames() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'itemNames');
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QDistinct> distinctByMallId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mallId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QDistinct> distinctByMallName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mallName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QDistinct> distinctByPeopleCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'peopleCount');
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QDistinct> distinctBySavedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'savedAt');
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QDistinct> distinctByShareText(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'shareText', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QDistinct> distinctByStallsUsed() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'stallsUsed');
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QDistinct> distinctByStrategyName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'strategyName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PlanHistory, PlanHistory, QDistinct> distinctByTotalCost() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalCost');
    });
  }
}

extension PlanHistoryQueryProperty
    on QueryBuilder<PlanHistory, PlanHistory, QQueryProperty> {
  QueryBuilder<PlanHistory, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<PlanHistory, List<String>, QQueryOperations>
      itemNamesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'itemNames');
    });
  }

  QueryBuilder<PlanHistory, String, QQueryOperations> mallIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mallId');
    });
  }

  QueryBuilder<PlanHistory, String, QQueryOperations> mallNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mallName');
    });
  }

  QueryBuilder<PlanHistory, int, QQueryOperations> peopleCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'peopleCount');
    });
  }

  QueryBuilder<PlanHistory, DateTime, QQueryOperations> savedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'savedAt');
    });
  }

  QueryBuilder<PlanHistory, String, QQueryOperations> shareTextProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'shareText');
    });
  }

  QueryBuilder<PlanHistory, List<String>, QQueryOperations>
      stallsUsedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'stallsUsed');
    });
  }

  QueryBuilder<PlanHistory, String, QQueryOperations> strategyNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'strategyName');
    });
  }

  QueryBuilder<PlanHistory, double, QQueryOperations> totalCostProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalCost');
    });
  }
}
