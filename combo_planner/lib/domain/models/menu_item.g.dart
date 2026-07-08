// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_item.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetMenuItemCollection on Isar {
  IsarCollection<MenuItem> get menuItems => this.collection();
}

const MenuItemSchema = CollectionSchema(
  name: r'MenuItem',
  id: -246808976978908556,
  properties: {
    r'basePrice': PropertySchema(
      id: 0,
      name: r'basePrice',
      type: IsarType.double,
    ),
    r'dietaryTag': PropertySchema(
      id: 1,
      name: r'dietaryTag',
      type: IsarType.string,
      enumMap: _MenuItemdietaryTagEnumValueMap,
    ),
    r'engineCategory': PropertySchema(
      id: 2,
      name: r'engineCategory',
      type: IsarType.string,
      enumMap: _MenuItemengineCategoryEnumValueMap,
    ),
    r'internalId': PropertySchema(
      id: 3,
      name: r'internalId',
      type: IsarType.string,
    ),
    r'isBlacklisted': PropertySchema(
      id: 4,
      name: r'isBlacklisted',
      type: IsarType.bool,
    ),
    r'mallId': PropertySchema(
      id: 5,
      name: r'mallId',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 6,
      name: r'name',
      type: IsarType.string,
    ),
    r'stallId': PropertySchema(
      id: 7,
      name: r'stallId',
      type: IsarType.string,
    ),
    r'stallName': PropertySchema(
      id: 8,
      name: r'stallName',
      type: IsarType.string,
    ),
    r'tags': PropertySchema(
      id: 9,
      name: r'tags',
      type: IsarType.stringList,
    ),
    r'taxAdjustedPrice': PropertySchema(
      id: 10,
      name: r'taxAdjustedPrice',
      type: IsarType.double,
    )
  },
  estimateSize: _menuItemEstimateSize,
  serialize: _menuItemSerialize,
  deserialize: _menuItemDeserialize,
  deserializeProp: _menuItemDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _menuItemGetId,
  getLinks: _menuItemGetLinks,
  attach: _menuItemAttach,
  version: '3.1.0+1',
);

int _menuItemEstimateSize(
  MenuItem object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.dietaryTag.name.length * 3;
  bytesCount += 3 + object.engineCategory.name.length * 3;
  bytesCount += 3 + object.internalId.length * 3;
  bytesCount += 3 + object.mallId.length * 3;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.stallId.length * 3;
  bytesCount += 3 + object.stallName.length * 3;
  bytesCount += 3 + object.tags.length * 3;
  {
    for (var i = 0; i < object.tags.length; i++) {
      final value = object.tags[i];
      bytesCount += value.length * 3;
    }
  }
  return bytesCount;
}

void _menuItemSerialize(
  MenuItem object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.basePrice);
  writer.writeString(offsets[1], object.dietaryTag.name);
  writer.writeString(offsets[2], object.engineCategory.name);
  writer.writeString(offsets[3], object.internalId);
  writer.writeBool(offsets[4], object.isBlacklisted);
  writer.writeString(offsets[5], object.mallId);
  writer.writeString(offsets[6], object.name);
  writer.writeString(offsets[7], object.stallId);
  writer.writeString(offsets[8], object.stallName);
  writer.writeStringList(offsets[9], object.tags);
  writer.writeDouble(offsets[10], object.taxAdjustedPrice);
}

MenuItem _menuItemDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MenuItem();
  object.basePrice = reader.readDouble(offsets[0]);
  object.dietaryTag =
      _MenuItemdietaryTagValueEnumMap[reader.readStringOrNull(offsets[1])] ??
          DietaryTag.veg;
  object.engineCategory = _MenuItemengineCategoryValueEnumMap[
          reader.readStringOrNull(offsets[2])] ??
      EngineCategory.main;
  object.id = id;
  object.internalId = reader.readString(offsets[3]);
  object.isBlacklisted = reader.readBool(offsets[4]);
  object.mallId = reader.readString(offsets[5]);
  object.name = reader.readString(offsets[6]);
  object.stallId = reader.readString(offsets[7]);
  object.stallName = reader.readString(offsets[8]);
  object.tags = reader.readStringList(offsets[9]) ?? [];
  object.taxAdjustedPrice = reader.readDouble(offsets[10]);
  return object;
}

P _menuItemDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (_MenuItemdietaryTagValueEnumMap[
              reader.readStringOrNull(offset)] ??
          DietaryTag.veg) as P;
    case 2:
      return (_MenuItemengineCategoryValueEnumMap[
              reader.readStringOrNull(offset)] ??
          EngineCategory.main) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readStringList(offset) ?? []) as P;
    case 10:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _MenuItemdietaryTagEnumValueMap = {
  r'veg': r'veg',
  r'nonVeg': r'nonVeg',
};
const _MenuItemdietaryTagValueEnumMap = {
  r'veg': DietaryTag.veg,
  r'nonVeg': DietaryTag.nonVeg,
};
const _MenuItemengineCategoryEnumValueMap = {
  r'main': r'main',
  r'side': r'side',
  r'beverage': r'beverage',
};
const _MenuItemengineCategoryValueEnumMap = {
  r'main': EngineCategory.main,
  r'side': EngineCategory.side,
  r'beverage': EngineCategory.beverage,
};

Id _menuItemGetId(MenuItem object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _menuItemGetLinks(MenuItem object) {
  return [];
}

void _menuItemAttach(IsarCollection<dynamic> col, Id id, MenuItem object) {
  object.id = id;
}

extension MenuItemQueryWhereSort on QueryBuilder<MenuItem, MenuItem, QWhere> {
  QueryBuilder<MenuItem, MenuItem, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension MenuItemQueryWhere on QueryBuilder<MenuItem, MenuItem, QWhereClause> {
  QueryBuilder<MenuItem, MenuItem, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<MenuItem, MenuItem, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterWhereClause> idBetween(
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

extension MenuItemQueryFilter
    on QueryBuilder<MenuItem, MenuItem, QFilterCondition> {
  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> basePriceEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'basePrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> basePriceGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'basePrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> basePriceLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'basePrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> basePriceBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'basePrice',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> dietaryTagEqualTo(
    DietaryTag value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dietaryTag',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> dietaryTagGreaterThan(
    DietaryTag value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dietaryTag',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> dietaryTagLessThan(
    DietaryTag value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dietaryTag',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> dietaryTagBetween(
    DietaryTag lower,
    DietaryTag upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dietaryTag',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> dietaryTagStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'dietaryTag',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> dietaryTagEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'dietaryTag',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> dietaryTagContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'dietaryTag',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> dietaryTagMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'dietaryTag',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> dietaryTagIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dietaryTag',
        value: '',
      ));
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition>
      dietaryTagIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'dietaryTag',
        value: '',
      ));
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> engineCategoryEqualTo(
    EngineCategory value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'engineCategory',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition>
      engineCategoryGreaterThan(
    EngineCategory value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'engineCategory',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition>
      engineCategoryLessThan(
    EngineCategory value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'engineCategory',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> engineCategoryBetween(
    EngineCategory lower,
    EngineCategory upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'engineCategory',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition>
      engineCategoryStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'engineCategory',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition>
      engineCategoryEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'engineCategory',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition>
      engineCategoryContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'engineCategory',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> engineCategoryMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'engineCategory',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition>
      engineCategoryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'engineCategory',
        value: '',
      ));
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition>
      engineCategoryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'engineCategory',
        value: '',
      ));
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> idBetween(
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

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> internalIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'internalId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> internalIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'internalId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> internalIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'internalId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> internalIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'internalId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> internalIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'internalId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> internalIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'internalId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> internalIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'internalId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> internalIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'internalId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> internalIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'internalId',
        value: '',
      ));
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition>
      internalIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'internalId',
        value: '',
      ));
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> isBlacklistedEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isBlacklisted',
        value: value,
      ));
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> mallIdEqualTo(
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

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> mallIdGreaterThan(
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

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> mallIdLessThan(
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

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> mallIdBetween(
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

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> mallIdStartsWith(
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

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> mallIdEndsWith(
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

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> mallIdContains(
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

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> mallIdMatches(
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

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> mallIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mallId',
        value: '',
      ));
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> mallIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mallId',
        value: '',
      ));
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> nameGreaterThan(
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

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> nameLessThan(
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

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> nameStartsWith(
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

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> stallIdEqualTo(
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

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> stallIdGreaterThan(
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

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> stallIdLessThan(
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

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> stallIdBetween(
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

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> stallIdStartsWith(
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

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> stallIdEndsWith(
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

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> stallIdContains(
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

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> stallIdMatches(
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

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> stallIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stallId',
        value: '',
      ));
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> stallIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'stallId',
        value: '',
      ));
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> stallNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stallName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> stallNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'stallName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> stallNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'stallName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> stallNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'stallName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> stallNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'stallName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> stallNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'stallName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> stallNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'stallName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> stallNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'stallName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> stallNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stallName',
        value: '',
      ));
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition>
      stallNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'stallName',
        value: '',
      ));
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> tagsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition>
      tagsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> tagsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> tagsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tags',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> tagsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> tagsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> tagsElementContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> tagsElementMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tags',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> tagsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tags',
        value: '',
      ));
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition>
      tagsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tags',
        value: '',
      ));
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> tagsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> tagsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> tagsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> tagsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> tagsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition> tagsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition>
      taxAdjustedPriceEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'taxAdjustedPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition>
      taxAdjustedPriceGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'taxAdjustedPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition>
      taxAdjustedPriceLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'taxAdjustedPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterFilterCondition>
      taxAdjustedPriceBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'taxAdjustedPrice',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension MenuItemQueryObject
    on QueryBuilder<MenuItem, MenuItem, QFilterCondition> {}

extension MenuItemQueryLinks
    on QueryBuilder<MenuItem, MenuItem, QFilterCondition> {}

extension MenuItemQuerySortBy on QueryBuilder<MenuItem, MenuItem, QSortBy> {
  QueryBuilder<MenuItem, MenuItem, QAfterSortBy> sortByBasePrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'basePrice', Sort.asc);
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterSortBy> sortByBasePriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'basePrice', Sort.desc);
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterSortBy> sortByDietaryTag() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dietaryTag', Sort.asc);
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterSortBy> sortByDietaryTagDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dietaryTag', Sort.desc);
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterSortBy> sortByEngineCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'engineCategory', Sort.asc);
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterSortBy> sortByEngineCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'engineCategory', Sort.desc);
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterSortBy> sortByInternalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'internalId', Sort.asc);
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterSortBy> sortByInternalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'internalId', Sort.desc);
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterSortBy> sortByIsBlacklisted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isBlacklisted', Sort.asc);
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterSortBy> sortByIsBlacklistedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isBlacklisted', Sort.desc);
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterSortBy> sortByMallId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mallId', Sort.asc);
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterSortBy> sortByMallIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mallId', Sort.desc);
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterSortBy> sortByStallId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stallId', Sort.asc);
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterSortBy> sortByStallIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stallId', Sort.desc);
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterSortBy> sortByStallName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stallName', Sort.asc);
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterSortBy> sortByStallNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stallName', Sort.desc);
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterSortBy> sortByTaxAdjustedPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taxAdjustedPrice', Sort.asc);
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterSortBy> sortByTaxAdjustedPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taxAdjustedPrice', Sort.desc);
    });
  }
}

extension MenuItemQuerySortThenBy
    on QueryBuilder<MenuItem, MenuItem, QSortThenBy> {
  QueryBuilder<MenuItem, MenuItem, QAfterSortBy> thenByBasePrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'basePrice', Sort.asc);
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterSortBy> thenByBasePriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'basePrice', Sort.desc);
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterSortBy> thenByDietaryTag() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dietaryTag', Sort.asc);
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterSortBy> thenByDietaryTagDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dietaryTag', Sort.desc);
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterSortBy> thenByEngineCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'engineCategory', Sort.asc);
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterSortBy> thenByEngineCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'engineCategory', Sort.desc);
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterSortBy> thenByInternalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'internalId', Sort.asc);
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterSortBy> thenByInternalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'internalId', Sort.desc);
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterSortBy> thenByIsBlacklisted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isBlacklisted', Sort.asc);
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterSortBy> thenByIsBlacklistedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isBlacklisted', Sort.desc);
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterSortBy> thenByMallId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mallId', Sort.asc);
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterSortBy> thenByMallIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mallId', Sort.desc);
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterSortBy> thenByStallId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stallId', Sort.asc);
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterSortBy> thenByStallIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stallId', Sort.desc);
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterSortBy> thenByStallName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stallName', Sort.asc);
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterSortBy> thenByStallNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stallName', Sort.desc);
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterSortBy> thenByTaxAdjustedPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taxAdjustedPrice', Sort.asc);
    });
  }

  QueryBuilder<MenuItem, MenuItem, QAfterSortBy> thenByTaxAdjustedPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taxAdjustedPrice', Sort.desc);
    });
  }
}

extension MenuItemQueryWhereDistinct
    on QueryBuilder<MenuItem, MenuItem, QDistinct> {
  QueryBuilder<MenuItem, MenuItem, QDistinct> distinctByBasePrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'basePrice');
    });
  }

  QueryBuilder<MenuItem, MenuItem, QDistinct> distinctByDietaryTag(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dietaryTag', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MenuItem, MenuItem, QDistinct> distinctByEngineCategory(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'engineCategory',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MenuItem, MenuItem, QDistinct> distinctByInternalId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'internalId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MenuItem, MenuItem, QDistinct> distinctByIsBlacklisted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isBlacklisted');
    });
  }

  QueryBuilder<MenuItem, MenuItem, QDistinct> distinctByMallId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mallId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MenuItem, MenuItem, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MenuItem, MenuItem, QDistinct> distinctByStallId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'stallId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MenuItem, MenuItem, QDistinct> distinctByStallName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'stallName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MenuItem, MenuItem, QDistinct> distinctByTags() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tags');
    });
  }

  QueryBuilder<MenuItem, MenuItem, QDistinct> distinctByTaxAdjustedPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'taxAdjustedPrice');
    });
  }
}

extension MenuItemQueryProperty
    on QueryBuilder<MenuItem, MenuItem, QQueryProperty> {
  QueryBuilder<MenuItem, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<MenuItem, double, QQueryOperations> basePriceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'basePrice');
    });
  }

  QueryBuilder<MenuItem, DietaryTag, QQueryOperations> dietaryTagProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dietaryTag');
    });
  }

  QueryBuilder<MenuItem, EngineCategory, QQueryOperations>
      engineCategoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'engineCategory');
    });
  }

  QueryBuilder<MenuItem, String, QQueryOperations> internalIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'internalId');
    });
  }

  QueryBuilder<MenuItem, bool, QQueryOperations> isBlacklistedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isBlacklisted');
    });
  }

  QueryBuilder<MenuItem, String, QQueryOperations> mallIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mallId');
    });
  }

  QueryBuilder<MenuItem, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<MenuItem, String, QQueryOperations> stallIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'stallId');
    });
  }

  QueryBuilder<MenuItem, String, QQueryOperations> stallNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'stallName');
    });
  }

  QueryBuilder<MenuItem, List<String>, QQueryOperations> tagsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tags');
    });
  }

  QueryBuilder<MenuItem, double, QQueryOperations> taxAdjustedPriceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'taxAdjustedPrice');
    });
  }
}
