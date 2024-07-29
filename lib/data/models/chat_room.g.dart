// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_room.dart';

// **************************************************************************
// CollectionGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, require_trailing_commas, prefer_single_quotes, prefer_double_quotes, use_super_parameters, duplicate_ignore
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_internal_member

class _Sentinel {
  const _Sentinel();
}

const _sentinel = _Sentinel();

/// A collection reference object can be used for adding documents,
/// getting document references, and querying for documents
/// (using the methods inherited from Query).
abstract class ChatRoomCollectionReference
    implements
        ChatRoomQuery,
        FirestoreCollectionReference<ChatRoom, ChatRoomQuerySnapshot> {
  factory ChatRoomCollectionReference([
    FirebaseFirestore? firestore,
  ]) = _$ChatRoomCollectionReference;

  static ChatRoom fromFirestore(
    DocumentSnapshot<Map<String, Object?>> snapshot,
    SnapshotOptions? options,
  ) {
    return ChatRoom.fromJson({'roomId': snapshot.id, ...?snapshot.data()});
  }

  static Map<String, Object?> toFirestore(
    ChatRoom value,
    SetOptions? options,
  ) {
    return {...value.toJson()}..remove('roomId');
  }

  @override
  CollectionReference<ChatRoom> get reference;

  @override
  ChatRoomDocumentReference doc([String? id]);

  /// Add a new document to this collection with the specified data,
  /// assigning it a document ID automatically.
  Future<ChatRoomDocumentReference> add(ChatRoom value);
}

class _$ChatRoomCollectionReference extends _$ChatRoomQuery
    implements ChatRoomCollectionReference {
  factory _$ChatRoomCollectionReference([FirebaseFirestore? firestore]) {
    firestore ??= FirebaseFirestore.instance;

    return _$ChatRoomCollectionReference._(
      firestore.collection('chatRooms').withConverter(
            fromFirestore: ChatRoomCollectionReference.fromFirestore,
            toFirestore: ChatRoomCollectionReference.toFirestore,
          ),
    );
  }

  _$ChatRoomCollectionReference._(
    CollectionReference<ChatRoom> reference,
  ) : super(reference, $referenceWithoutCursor: reference);

  String get path => reference.path;

  @override
  CollectionReference<ChatRoom> get reference =>
      super.reference as CollectionReference<ChatRoom>;

  @override
  ChatRoomDocumentReference doc([String? id]) {
    assert(
      id == null || id.split('/').length == 1,
      'The document ID cannot be from a different collection',
    );
    return ChatRoomDocumentReference(
      reference.doc(id),
    );
  }

  @override
  Future<ChatRoomDocumentReference> add(ChatRoom value) {
    return reference.add(value).then((ref) => ChatRoomDocumentReference(ref));
  }

  @override
  bool operator ==(Object other) {
    return other is _$ChatRoomCollectionReference &&
        other.runtimeType == runtimeType &&
        other.reference == reference;
  }

  @override
  int get hashCode => Object.hash(runtimeType, reference);
}

abstract class ChatRoomDocumentReference
    extends FirestoreDocumentReference<ChatRoom, ChatRoomDocumentSnapshot> {
  factory ChatRoomDocumentReference(DocumentReference<ChatRoom> reference) =
      _$ChatRoomDocumentReference;

  DocumentReference<ChatRoom> get reference;

  /// A reference to the [ChatRoomCollectionReference] containing this document.
  ChatRoomCollectionReference get parent {
    return _$ChatRoomCollectionReference(reference.firestore);
  }

  @override
  Stream<ChatRoomDocumentSnapshot> snapshots();

  @override
  Future<ChatRoomDocumentSnapshot> get([GetOptions? options]);

  @override
  Future<void> delete();

  /// Updates data on the document. Data will be merged with any existing
  /// document data.
  ///
  /// If no document exists yet, the update will fail.
  Future<void> update({
    List<UserModel> users,
    FieldValue usersFieldValue,
    Message? lastMessage,
    FieldValue lastMessageFieldValue,
    int unreadedMessage,
    FieldValue unreadedMessageFieldValue,
  });

  /// Updates fields in the current document using the transaction API.
  ///
  /// The update will fail if applied to a document that does not exist.
  void transactionUpdate(
    Transaction transaction, {
    List<UserModel> users,
    FieldValue usersFieldValue,
    Message? lastMessage,
    FieldValue lastMessageFieldValue,
    int unreadedMessage,
    FieldValue unreadedMessageFieldValue,
  });

  /// Updates fields in the current document using the batch API.
  ///
  /// The update will fail if applied to a document that does not exist.
  void batchUpdate(
    WriteBatch batch, {
    List<UserModel> users,
    FieldValue usersFieldValue,
    Message? lastMessage,
    FieldValue lastMessageFieldValue,
    int unreadedMessage,
    FieldValue unreadedMessageFieldValue,
  });
}

class _$ChatRoomDocumentReference
    extends FirestoreDocumentReference<ChatRoom, ChatRoomDocumentSnapshot>
    implements ChatRoomDocumentReference {
  _$ChatRoomDocumentReference(this.reference);

  @override
  final DocumentReference<ChatRoom> reference;

  /// A reference to the [ChatRoomCollectionReference] containing this document.
  ChatRoomCollectionReference get parent {
    return _$ChatRoomCollectionReference(reference.firestore);
  }

  @override
  Stream<ChatRoomDocumentSnapshot> snapshots() {
    return reference.snapshots().map(ChatRoomDocumentSnapshot._);
  }

  @override
  Future<ChatRoomDocumentSnapshot> get([GetOptions? options]) {
    return reference.get(options).then(ChatRoomDocumentSnapshot._);
  }

  @override
  Future<ChatRoomDocumentSnapshot> transactionGet(Transaction transaction) {
    return transaction.get(reference).then(ChatRoomDocumentSnapshot._);
  }

  Future<void> update({
    Object? users = _sentinel,
    FieldValue? usersFieldValue,
    Object? lastMessage = _sentinel,
    FieldValue? lastMessageFieldValue,
    Object? unreadedMessage = _sentinel,
    FieldValue? unreadedMessageFieldValue,
  }) async {
    assert(
      users == _sentinel || usersFieldValue == null,
      "Cannot specify both users and usersFieldValue",
    );
    assert(
      lastMessage == _sentinel || lastMessageFieldValue == null,
      "Cannot specify both lastMessage and lastMessageFieldValue",
    );
    assert(
      unreadedMessage == _sentinel || unreadedMessageFieldValue == null,
      "Cannot specify both unreadedMessage and unreadedMessageFieldValue",
    );
    final json = {
      if (users != _sentinel)
        _$$ChatRoomImplFieldMap['users']!:
            _$$ChatRoomImplPerFieldToJson.users(users as List<UserModel>),
      if (usersFieldValue != null)
        _$$ChatRoomImplFieldMap['users']!: usersFieldValue,
      if (lastMessage != _sentinel)
        _$$ChatRoomImplFieldMap['lastMessage']!:
            _$$ChatRoomImplPerFieldToJson.lastMessage(lastMessage as Message?),
      if (lastMessageFieldValue != null)
        _$$ChatRoomImplFieldMap['lastMessage']!: lastMessageFieldValue,
      if (unreadedMessage != _sentinel)
        _$$ChatRoomImplFieldMap['unreadedMessage']!:
            _$$ChatRoomImplPerFieldToJson
                .unreadedMessage(unreadedMessage as int),
      if (unreadedMessageFieldValue != null)
        _$$ChatRoomImplFieldMap['unreadedMessage']!: unreadedMessageFieldValue,
    };

    return reference.update(json);
  }

  void transactionUpdate(
    Transaction transaction, {
    Object? users = _sentinel,
    FieldValue? usersFieldValue,
    Object? lastMessage = _sentinel,
    FieldValue? lastMessageFieldValue,
    Object? unreadedMessage = _sentinel,
    FieldValue? unreadedMessageFieldValue,
  }) {
    assert(
      users == _sentinel || usersFieldValue == null,
      "Cannot specify both users and usersFieldValue",
    );
    assert(
      lastMessage == _sentinel || lastMessageFieldValue == null,
      "Cannot specify both lastMessage and lastMessageFieldValue",
    );
    assert(
      unreadedMessage == _sentinel || unreadedMessageFieldValue == null,
      "Cannot specify both unreadedMessage and unreadedMessageFieldValue",
    );
    final json = {
      if (users != _sentinel)
        _$$ChatRoomImplFieldMap['users']!:
            _$$ChatRoomImplPerFieldToJson.users(users as List<UserModel>),
      if (usersFieldValue != null)
        _$$ChatRoomImplFieldMap['users']!: usersFieldValue,
      if (lastMessage != _sentinel)
        _$$ChatRoomImplFieldMap['lastMessage']!:
            _$$ChatRoomImplPerFieldToJson.lastMessage(lastMessage as Message?),
      if (lastMessageFieldValue != null)
        _$$ChatRoomImplFieldMap['lastMessage']!: lastMessageFieldValue,
      if (unreadedMessage != _sentinel)
        _$$ChatRoomImplFieldMap['unreadedMessage']!:
            _$$ChatRoomImplPerFieldToJson
                .unreadedMessage(unreadedMessage as int),
      if (unreadedMessageFieldValue != null)
        _$$ChatRoomImplFieldMap['unreadedMessage']!: unreadedMessageFieldValue,
    };

    transaction.update(reference, json);
  }

  void batchUpdate(
    WriteBatch batch, {
    Object? users = _sentinel,
    FieldValue? usersFieldValue,
    Object? lastMessage = _sentinel,
    FieldValue? lastMessageFieldValue,
    Object? unreadedMessage = _sentinel,
    FieldValue? unreadedMessageFieldValue,
  }) {
    assert(
      users == _sentinel || usersFieldValue == null,
      "Cannot specify both users and usersFieldValue",
    );
    assert(
      lastMessage == _sentinel || lastMessageFieldValue == null,
      "Cannot specify both lastMessage and lastMessageFieldValue",
    );
    assert(
      unreadedMessage == _sentinel || unreadedMessageFieldValue == null,
      "Cannot specify both unreadedMessage and unreadedMessageFieldValue",
    );
    final json = {
      if (users != _sentinel)
        _$$ChatRoomImplFieldMap['users']!:
            _$$ChatRoomImplPerFieldToJson.users(users as List<UserModel>),
      if (usersFieldValue != null)
        _$$ChatRoomImplFieldMap['users']!: usersFieldValue,
      if (lastMessage != _sentinel)
        _$$ChatRoomImplFieldMap['lastMessage']!:
            _$$ChatRoomImplPerFieldToJson.lastMessage(lastMessage as Message?),
      if (lastMessageFieldValue != null)
        _$$ChatRoomImplFieldMap['lastMessage']!: lastMessageFieldValue,
      if (unreadedMessage != _sentinel)
        _$$ChatRoomImplFieldMap['unreadedMessage']!:
            _$$ChatRoomImplPerFieldToJson
                .unreadedMessage(unreadedMessage as int),
      if (unreadedMessageFieldValue != null)
        _$$ChatRoomImplFieldMap['unreadedMessage']!: unreadedMessageFieldValue,
    };

    batch.update(reference, json);
  }

  @override
  bool operator ==(Object other) {
    return other is ChatRoomDocumentReference &&
        other.runtimeType == runtimeType &&
        other.parent == parent &&
        other.id == id;
  }

  @override
  int get hashCode => Object.hash(runtimeType, parent, id);
}

abstract class ChatRoomQuery
    implements QueryReference<ChatRoom, ChatRoomQuerySnapshot> {
  @override
  ChatRoomQuery limit(int limit);

  @override
  ChatRoomQuery limitToLast(int limit);

  /// Perform a where query based on a [FieldPath].
  ///
  /// This method is considered unsafe as it does check that the field path
  /// maps to a valid property or that parameters such as [isEqualTo] receive
  /// a value of the correct type.
  ///
  /// If possible, instead use the more explicit variant of where queries:
  ///
  /// **AVOID**:
  /// ```dart
  /// collection.whereFieldPath(FieldPath.fromString('title'), isEqualTo: 'title');
  /// ```
  ///
  /// **PREFER**:
  /// ```dart
  /// collection.whereTitle(isEqualTo: 'title');
  /// ```
  ChatRoomQuery whereFieldPath(
    Object fieldPath, {
    Object? isEqualTo,
    Object? isNotEqualTo,
    Object? isLessThan,
    Object? isLessThanOrEqualTo,
    Object? isGreaterThan,
    Object? isGreaterThanOrEqualTo,
    Object? arrayContains,
    List<Object?>? arrayContainsAny,
    List<Object?>? whereIn,
    List<Object?>? whereNotIn,
    bool? isNull,
  });

  ChatRoomQuery whereDocumentId({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    List<String>? whereIn,
    List<String>? whereNotIn,
    bool? isNull,
  });

  ChatRoomQuery whereUsers({
    List<UserModel>? isEqualTo,
    List<UserModel>? isNotEqualTo,
    List<UserModel>? isLessThan,
    List<UserModel>? isLessThanOrEqualTo,
    List<UserModel>? isGreaterThan,
    List<UserModel>? isGreaterThanOrEqualTo,
    UserModel? arrayContains,
    List<UserModel>? arrayContainsAny,
    bool? isNull,
  });

  ChatRoomQuery whereLastMessage({
    Message? isEqualTo,
    Message? isNotEqualTo,
    Message? isLessThan,
    Message? isLessThanOrEqualTo,
    Message? isGreaterThan,
    Message? isGreaterThanOrEqualTo,
    List<Message?>? whereIn,
    List<Message?>? whereNotIn,
    bool? isNull,
  });

  ChatRoomQuery whereUnreadedMessage({
    int? isEqualTo,
    int? isNotEqualTo,
    int? isLessThan,
    int? isLessThanOrEqualTo,
    int? isGreaterThan,
    int? isGreaterThanOrEqualTo,
    List<int>? whereIn,
    List<int>? whereNotIn,
    bool? isNull,
  });

  /// Perform an order query based on a [FieldPath].
  ///
  /// This method is considered unsafe as it does check that the field path
  /// maps to a valid property or that parameters such as [isEqualTo] receive
  /// a value of the correct type.
  ///
  /// If possible, instead use the more explicit variant of order queries:
  ///
  /// **AVOID**:
  /// ```dart
  /// collection.orderByFieldPath(
  ///   FieldPath.fromString('title'),
  ///   startAt: 'title',
  /// );
  /// ```
  ///
  /// **PREFER**:
  /// ```dart
  /// collection.orderByTitle(startAt: 'title');
  /// ```
  ChatRoomQuery orderByFieldPath(
    Object fieldPath, {
    bool descending = false,
    Object startAt,
    Object startAfter,
    Object endAt,
    Object endBefore,
    ChatRoomDocumentSnapshot? startAtDocument,
    ChatRoomDocumentSnapshot? endAtDocument,
    ChatRoomDocumentSnapshot? endBeforeDocument,
    ChatRoomDocumentSnapshot? startAfterDocument,
  });

  ChatRoomQuery orderByDocumentId({
    bool descending = false,
    String startAt,
    String startAfter,
    String endAt,
    String endBefore,
    ChatRoomDocumentSnapshot? startAtDocument,
    ChatRoomDocumentSnapshot? endAtDocument,
    ChatRoomDocumentSnapshot? endBeforeDocument,
    ChatRoomDocumentSnapshot? startAfterDocument,
  });

  ChatRoomQuery orderByUsers({
    bool descending = false,
    List<UserModel> startAt,
    List<UserModel> startAfter,
    List<UserModel> endAt,
    List<UserModel> endBefore,
    ChatRoomDocumentSnapshot? startAtDocument,
    ChatRoomDocumentSnapshot? endAtDocument,
    ChatRoomDocumentSnapshot? endBeforeDocument,
    ChatRoomDocumentSnapshot? startAfterDocument,
  });

  ChatRoomQuery orderByLastMessage({
    bool descending = false,
    Message? startAt,
    Message? startAfter,
    Message? endAt,
    Message? endBefore,
    ChatRoomDocumentSnapshot? startAtDocument,
    ChatRoomDocumentSnapshot? endAtDocument,
    ChatRoomDocumentSnapshot? endBeforeDocument,
    ChatRoomDocumentSnapshot? startAfterDocument,
  });

  ChatRoomQuery orderByUnreadedMessage({
    bool descending = false,
    int startAt,
    int startAfter,
    int endAt,
    int endBefore,
    ChatRoomDocumentSnapshot? startAtDocument,
    ChatRoomDocumentSnapshot? endAtDocument,
    ChatRoomDocumentSnapshot? endBeforeDocument,
    ChatRoomDocumentSnapshot? startAfterDocument,
  });
}

class _$ChatRoomQuery extends QueryReference<ChatRoom, ChatRoomQuerySnapshot>
    implements ChatRoomQuery {
  _$ChatRoomQuery(
    this._collection, {
    required Query<ChatRoom> $referenceWithoutCursor,
    $QueryCursor $queryCursor = const $QueryCursor(),
  }) : super(
          $referenceWithoutCursor: $referenceWithoutCursor,
          $queryCursor: $queryCursor,
        );

  final CollectionReference<Object?> _collection;

  @override
  Stream<ChatRoomQuerySnapshot> snapshots([SnapshotOptions? options]) {
    return reference.snapshots().map(ChatRoomQuerySnapshot._fromQuerySnapshot);
  }

  @override
  Future<ChatRoomQuerySnapshot> get([GetOptions? options]) {
    return reference
        .get(options)
        .then(ChatRoomQuerySnapshot._fromQuerySnapshot);
  }

  @override
  ChatRoomQuery limit(int limit) {
    return _$ChatRoomQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.limit(limit),
      $queryCursor: $queryCursor,
    );
  }

  @override
  ChatRoomQuery limitToLast(int limit) {
    return _$ChatRoomQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.limitToLast(limit),
      $queryCursor: $queryCursor,
    );
  }

  @override
  ChatRoomQuery whereFieldPath(
    Object fieldPath, {
    Object? isEqualTo = _sentinel,
    Object? isNotEqualTo = _sentinel,
    Object? isLessThan,
    Object? isLessThanOrEqualTo,
    Object? isGreaterThan,
    Object? isGreaterThanOrEqualTo,
    Object? arrayContains,
    List<Object?>? arrayContainsAny,
    List<Object?>? whereIn,
    List<Object?>? whereNotIn,
    bool? isNull,
  }) {
    return _$ChatRoomQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.where(
        fieldPath,
        isEqualTo: isEqualTo != _sentinel ? isEqualTo : null,
        isNotEqualTo: isNotEqualTo != _sentinel ? isNotEqualTo : null,
        isLessThan: isLessThan,
        isLessThanOrEqualTo: isLessThanOrEqualTo,
        isGreaterThan: isGreaterThan,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
        arrayContains: arrayContains,
        arrayContainsAny: arrayContainsAny,
        whereIn: whereIn,
        whereNotIn: whereNotIn,
        isNull: isNull ??
            (isEqualTo == null ? false : null) ??
            (isNotEqualTo == null ? true : null),
      ),
      $queryCursor: $queryCursor,
    );
  }

  @override
  ChatRoomQuery whereDocumentId({
    Object? isEqualTo = _sentinel,
    Object? isNotEqualTo = _sentinel,
    Object? isLessThan,
    Object? isLessThanOrEqualTo,
    Object? isGreaterThan,
    Object? isGreaterThanOrEqualTo,
    List<String>? whereIn,
    List<String>? whereNotIn,
    bool? isNull,
  }) {
    return _$ChatRoomQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.where(
        FieldPath.documentId,
        isEqualTo: isEqualTo != _sentinel ? isEqualTo : null,
        isNotEqualTo: isNotEqualTo != _sentinel ? isNotEqualTo : null,
        isLessThan: isLessThan,
        isLessThanOrEqualTo: isLessThanOrEqualTo,
        isGreaterThan: isGreaterThan,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
        whereIn: whereIn,
        whereNotIn: whereNotIn,
        isNull: isNull ??
            (isEqualTo == null ? false : null) ??
            (isNotEqualTo == null ? true : null),
      ),
      $queryCursor: $queryCursor,
    );
  }

  @override
  ChatRoomQuery whereUsers({
    Object? isEqualTo = _sentinel,
    Object? isNotEqualTo = _sentinel,
    Object? isLessThan,
    Object? isLessThanOrEqualTo,
    Object? isGreaterThan,
    Object? isGreaterThanOrEqualTo,
    Object? arrayContains,
    List<UserModel>? arrayContainsAny,
    bool? isNull,
  }) {
    return _$ChatRoomQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.where(
        _$$ChatRoomImplFieldMap['users']!,
        isEqualTo: isEqualTo != _sentinel
            ? _$$ChatRoomImplPerFieldToJson.users(isEqualTo as List<UserModel>)
            : null,
        isNotEqualTo: isNotEqualTo != _sentinel
            ? _$$ChatRoomImplPerFieldToJson
                .users(isNotEqualTo as List<UserModel>)
            : null,
        isLessThan: isLessThan != null
            ? _$$ChatRoomImplPerFieldToJson.users(isLessThan as List<UserModel>)
            : null,
        isLessThanOrEqualTo: isLessThanOrEqualTo != null
            ? _$$ChatRoomImplPerFieldToJson
                .users(isLessThanOrEqualTo as List<UserModel>)
            : null,
        isGreaterThan: isGreaterThan != null
            ? _$$ChatRoomImplPerFieldToJson
                .users(isGreaterThan as List<UserModel>)
            : null,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo != null
            ? _$$ChatRoomImplPerFieldToJson
                .users(isGreaterThanOrEqualTo as List<UserModel>)
            : null,
        arrayContains: arrayContains != null
            ? (_$$ChatRoomImplPerFieldToJson.users([arrayContains as UserModel])
                    as List?)!
                .single
            : null,
        arrayContainsAny: arrayContainsAny != null
            ? _$$ChatRoomImplPerFieldToJson.users(arrayContainsAny)
                as Iterable<Object>?
            : null,
        isNull: isNull ??
            (isEqualTo == null ? false : null) ??
            (isNotEqualTo == null ? true : null),
      ),
      $queryCursor: $queryCursor,
    );
  }

  @override
  ChatRoomQuery whereLastMessage({
    Object? isEqualTo = _sentinel,
    Object? isNotEqualTo = _sentinel,
    Object? isLessThan,
    Object? isLessThanOrEqualTo,
    Object? isGreaterThan,
    Object? isGreaterThanOrEqualTo,
    List<Message?>? whereIn,
    List<Message?>? whereNotIn,
    bool? isNull,
  }) {
    return _$ChatRoomQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.where(
        _$$ChatRoomImplFieldMap['lastMessage']!,
        isEqualTo: isEqualTo != _sentinel
            ? _$$ChatRoomImplPerFieldToJson.lastMessage(isEqualTo as Message?)
            : null,
        isNotEqualTo: isNotEqualTo != _sentinel
            ? _$$ChatRoomImplPerFieldToJson
                .lastMessage(isNotEqualTo as Message?)
            : null,
        isLessThan: isLessThan != null
            ? _$$ChatRoomImplPerFieldToJson.lastMessage(isLessThan as Message?)
            : null,
        isLessThanOrEqualTo: isLessThanOrEqualTo != null
            ? _$$ChatRoomImplPerFieldToJson
                .lastMessage(isLessThanOrEqualTo as Message?)
            : null,
        isGreaterThan: isGreaterThan != null
            ? _$$ChatRoomImplPerFieldToJson
                .lastMessage(isGreaterThan as Message?)
            : null,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo != null
            ? _$$ChatRoomImplPerFieldToJson
                .lastMessage(isGreaterThanOrEqualTo as Message?)
            : null,
        whereIn:
            whereIn?.map((e) => _$$ChatRoomImplPerFieldToJson.lastMessage(e)),
        whereNotIn: whereNotIn
            ?.map((e) => _$$ChatRoomImplPerFieldToJson.lastMessage(e)),
        isNull: isNull ??
            (isEqualTo == null ? false : null) ??
            (isNotEqualTo == null ? true : null),
      ),
      $queryCursor: $queryCursor,
    );
  }

  @override
  ChatRoomQuery whereUnreadedMessage({
    Object? isEqualTo = _sentinel,
    Object? isNotEqualTo = _sentinel,
    Object? isLessThan,
    Object? isLessThanOrEqualTo,
    Object? isGreaterThan,
    Object? isGreaterThanOrEqualTo,
    List<int>? whereIn,
    List<int>? whereNotIn,
    bool? isNull,
  }) {
    return _$ChatRoomQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.where(
        _$$ChatRoomImplFieldMap['unreadedMessage']!,
        isEqualTo: isEqualTo != _sentinel
            ? _$$ChatRoomImplPerFieldToJson.unreadedMessage(isEqualTo as int)
            : null,
        isNotEqualTo: isNotEqualTo != _sentinel
            ? _$$ChatRoomImplPerFieldToJson.unreadedMessage(isNotEqualTo as int)
            : null,
        isLessThan: isLessThan != null
            ? _$$ChatRoomImplPerFieldToJson.unreadedMessage(isLessThan as int)
            : null,
        isLessThanOrEqualTo: isLessThanOrEqualTo != null
            ? _$$ChatRoomImplPerFieldToJson
                .unreadedMessage(isLessThanOrEqualTo as int)
            : null,
        isGreaterThan: isGreaterThan != null
            ? _$$ChatRoomImplPerFieldToJson
                .unreadedMessage(isGreaterThan as int)
            : null,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo != null
            ? _$$ChatRoomImplPerFieldToJson
                .unreadedMessage(isGreaterThanOrEqualTo as int)
            : null,
        whereIn: whereIn
            ?.map((e) => _$$ChatRoomImplPerFieldToJson.unreadedMessage(e)),
        whereNotIn: whereNotIn
            ?.map((e) => _$$ChatRoomImplPerFieldToJson.unreadedMessage(e)),
        isNull: isNull ??
            (isEqualTo == null ? false : null) ??
            (isNotEqualTo == null ? true : null),
      ),
      $queryCursor: $queryCursor,
    );
  }

  @override
  ChatRoomQuery orderByFieldPath(
    Object fieldPath, {
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    ChatRoomDocumentSnapshot? startAtDocument,
    ChatRoomDocumentSnapshot? endAtDocument,
    ChatRoomDocumentSnapshot? endBeforeDocument,
    ChatRoomDocumentSnapshot? startAfterDocument,
  }) {
    final query =
        $referenceWithoutCursor.orderBy(fieldPath, descending: descending);
    var queryCursor = $queryCursor;

    if (startAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAt: const [],
        startAtDocumentSnapshot: startAtDocument.snapshot,
      );
    }
    if (startAfterDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAfter: const [],
        startAfterDocumentSnapshot: startAfterDocument.snapshot,
      );
    }
    if (endAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        endAt: const [],
        endAtDocumentSnapshot: endAtDocument.snapshot,
      );
    }
    if (endBeforeDocument != null) {
      queryCursor = queryCursor.copyWith(
        endBefore: const [],
        endBeforeDocumentSnapshot: endBeforeDocument.snapshot,
      );
    }

    if (startAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAt: [...queryCursor.startAt, startAt],
        startAtDocumentSnapshot: null,
      );
    }
    if (startAfter != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAfter: [...queryCursor.startAfter, startAfter],
        startAfterDocumentSnapshot: null,
      );
    }
    if (endAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endAt: [...queryCursor.endAt, endAt],
        endAtDocumentSnapshot: null,
      );
    }
    if (endBefore != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endBefore: [...queryCursor.endBefore, endBefore],
        endBeforeDocumentSnapshot: null,
      );
    }

    return _$ChatRoomQuery(
      _collection,
      $referenceWithoutCursor: query,
      $queryCursor: queryCursor,
    );
  }

  @override
  ChatRoomQuery orderByDocumentId({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    ChatRoomDocumentSnapshot? startAtDocument,
    ChatRoomDocumentSnapshot? endAtDocument,
    ChatRoomDocumentSnapshot? endBeforeDocument,
    ChatRoomDocumentSnapshot? startAfterDocument,
  }) {
    final query = $referenceWithoutCursor.orderBy(FieldPath.documentId,
        descending: descending);
    var queryCursor = $queryCursor;

    if (startAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAt: const [],
        startAtDocumentSnapshot: startAtDocument.snapshot,
      );
    }
    if (startAfterDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAfter: const [],
        startAfterDocumentSnapshot: startAfterDocument.snapshot,
      );
    }
    if (endAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        endAt: const [],
        endAtDocumentSnapshot: endAtDocument.snapshot,
      );
    }
    if (endBeforeDocument != null) {
      queryCursor = queryCursor.copyWith(
        endBefore: const [],
        endBeforeDocumentSnapshot: endBeforeDocument.snapshot,
      );
    }

    if (startAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAt: [...queryCursor.startAt, startAt],
        startAtDocumentSnapshot: null,
      );
    }
    if (startAfter != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAfter: [...queryCursor.startAfter, startAfter],
        startAfterDocumentSnapshot: null,
      );
    }
    if (endAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endAt: [...queryCursor.endAt, endAt],
        endAtDocumentSnapshot: null,
      );
    }
    if (endBefore != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endBefore: [...queryCursor.endBefore, endBefore],
        endBeforeDocumentSnapshot: null,
      );
    }

    return _$ChatRoomQuery(
      _collection,
      $referenceWithoutCursor: query,
      $queryCursor: queryCursor,
    );
  }

  @override
  ChatRoomQuery orderByUsers({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    ChatRoomDocumentSnapshot? startAtDocument,
    ChatRoomDocumentSnapshot? endAtDocument,
    ChatRoomDocumentSnapshot? endBeforeDocument,
    ChatRoomDocumentSnapshot? startAfterDocument,
  }) {
    final query = $referenceWithoutCursor
        .orderBy(_$$ChatRoomImplFieldMap['users']!, descending: descending);
    var queryCursor = $queryCursor;

    if (startAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAt: const [],
        startAtDocumentSnapshot: startAtDocument.snapshot,
      );
    }
    if (startAfterDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAfter: const [],
        startAfterDocumentSnapshot: startAfterDocument.snapshot,
      );
    }
    if (endAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        endAt: const [],
        endAtDocumentSnapshot: endAtDocument.snapshot,
      );
    }
    if (endBeforeDocument != null) {
      queryCursor = queryCursor.copyWith(
        endBefore: const [],
        endBeforeDocumentSnapshot: endBeforeDocument.snapshot,
      );
    }

    if (startAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAt: [...queryCursor.startAt, startAt],
        startAtDocumentSnapshot: null,
      );
    }
    if (startAfter != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAfter: [...queryCursor.startAfter, startAfter],
        startAfterDocumentSnapshot: null,
      );
    }
    if (endAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endAt: [...queryCursor.endAt, endAt],
        endAtDocumentSnapshot: null,
      );
    }
    if (endBefore != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endBefore: [...queryCursor.endBefore, endBefore],
        endBeforeDocumentSnapshot: null,
      );
    }

    return _$ChatRoomQuery(
      _collection,
      $referenceWithoutCursor: query,
      $queryCursor: queryCursor,
    );
  }

  @override
  ChatRoomQuery orderByLastMessage({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    ChatRoomDocumentSnapshot? startAtDocument,
    ChatRoomDocumentSnapshot? endAtDocument,
    ChatRoomDocumentSnapshot? endBeforeDocument,
    ChatRoomDocumentSnapshot? startAfterDocument,
  }) {
    final query = $referenceWithoutCursor.orderBy(
        _$$ChatRoomImplFieldMap['lastMessage']!,
        descending: descending);
    var queryCursor = $queryCursor;

    if (startAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAt: const [],
        startAtDocumentSnapshot: startAtDocument.snapshot,
      );
    }
    if (startAfterDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAfter: const [],
        startAfterDocumentSnapshot: startAfterDocument.snapshot,
      );
    }
    if (endAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        endAt: const [],
        endAtDocumentSnapshot: endAtDocument.snapshot,
      );
    }
    if (endBeforeDocument != null) {
      queryCursor = queryCursor.copyWith(
        endBefore: const [],
        endBeforeDocumentSnapshot: endBeforeDocument.snapshot,
      );
    }

    if (startAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAt: [...queryCursor.startAt, startAt],
        startAtDocumentSnapshot: null,
      );
    }
    if (startAfter != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAfter: [...queryCursor.startAfter, startAfter],
        startAfterDocumentSnapshot: null,
      );
    }
    if (endAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endAt: [...queryCursor.endAt, endAt],
        endAtDocumentSnapshot: null,
      );
    }
    if (endBefore != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endBefore: [...queryCursor.endBefore, endBefore],
        endBeforeDocumentSnapshot: null,
      );
    }

    return _$ChatRoomQuery(
      _collection,
      $referenceWithoutCursor: query,
      $queryCursor: queryCursor,
    );
  }

  @override
  ChatRoomQuery orderByUnreadedMessage({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    ChatRoomDocumentSnapshot? startAtDocument,
    ChatRoomDocumentSnapshot? endAtDocument,
    ChatRoomDocumentSnapshot? endBeforeDocument,
    ChatRoomDocumentSnapshot? startAfterDocument,
  }) {
    final query = $referenceWithoutCursor.orderBy(
        _$$ChatRoomImplFieldMap['unreadedMessage']!,
        descending: descending);
    var queryCursor = $queryCursor;

    if (startAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAt: const [],
        startAtDocumentSnapshot: startAtDocument.snapshot,
      );
    }
    if (startAfterDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAfter: const [],
        startAfterDocumentSnapshot: startAfterDocument.snapshot,
      );
    }
    if (endAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        endAt: const [],
        endAtDocumentSnapshot: endAtDocument.snapshot,
      );
    }
    if (endBeforeDocument != null) {
      queryCursor = queryCursor.copyWith(
        endBefore: const [],
        endBeforeDocumentSnapshot: endBeforeDocument.snapshot,
      );
    }

    if (startAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAt: [...queryCursor.startAt, startAt],
        startAtDocumentSnapshot: null,
      );
    }
    if (startAfter != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAfter: [...queryCursor.startAfter, startAfter],
        startAfterDocumentSnapshot: null,
      );
    }
    if (endAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endAt: [...queryCursor.endAt, endAt],
        endAtDocumentSnapshot: null,
      );
    }
    if (endBefore != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endBefore: [...queryCursor.endBefore, endBefore],
        endBeforeDocumentSnapshot: null,
      );
    }

    return _$ChatRoomQuery(
      _collection,
      $referenceWithoutCursor: query,
      $queryCursor: queryCursor,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is _$ChatRoomQuery &&
        other.runtimeType == runtimeType &&
        other.reference == reference;
  }

  @override
  int get hashCode => Object.hash(runtimeType, reference);
}

class ChatRoomDocumentSnapshot extends FirestoreDocumentSnapshot<ChatRoom> {
  ChatRoomDocumentSnapshot._(this.snapshot) : data = snapshot.data();

  @override
  final DocumentSnapshot<ChatRoom> snapshot;

  @override
  ChatRoomDocumentReference get reference {
    return ChatRoomDocumentReference(
      snapshot.reference,
    );
  }

  @override
  final ChatRoom? data;
}

class ChatRoomQuerySnapshot
    extends FirestoreQuerySnapshot<ChatRoom, ChatRoomQueryDocumentSnapshot> {
  ChatRoomQuerySnapshot._(
    this.snapshot,
    this.docs,
    this.docChanges,
  );

  factory ChatRoomQuerySnapshot._fromQuerySnapshot(
    QuerySnapshot<ChatRoom> snapshot,
  ) {
    final docs = snapshot.docs.map(ChatRoomQueryDocumentSnapshot._).toList();

    final docChanges = snapshot.docChanges.map((change) {
      return _decodeDocumentChange(
        change,
        ChatRoomDocumentSnapshot._,
      );
    }).toList();

    return ChatRoomQuerySnapshot._(
      snapshot,
      docs,
      docChanges,
    );
  }

  static FirestoreDocumentChange<ChatRoomDocumentSnapshot>
      _decodeDocumentChange<T>(
    DocumentChange<T> docChange,
    ChatRoomDocumentSnapshot Function(DocumentSnapshot<T> doc) decodeDoc,
  ) {
    return FirestoreDocumentChange<ChatRoomDocumentSnapshot>(
      type: docChange.type,
      oldIndex: docChange.oldIndex,
      newIndex: docChange.newIndex,
      doc: decodeDoc(docChange.doc),
    );
  }

  final QuerySnapshot<ChatRoom> snapshot;

  @override
  final List<ChatRoomQueryDocumentSnapshot> docs;

  @override
  final List<FirestoreDocumentChange<ChatRoomDocumentSnapshot>> docChanges;
}

class ChatRoomQueryDocumentSnapshot
    extends FirestoreQueryDocumentSnapshot<ChatRoom>
    implements ChatRoomDocumentSnapshot {
  ChatRoomQueryDocumentSnapshot._(this.snapshot) : data = snapshot.data();

  @override
  final QueryDocumentSnapshot<ChatRoom> snapshot;

  @override
  final ChatRoom data;

  @override
  ChatRoomDocumentReference get reference {
    return ChatRoomDocumentReference(snapshot.reference);
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatRoomImpl _$$ChatRoomImplFromJson(Map<String, dynamic> json) =>
    _$ChatRoomImpl(
      roomId: json['roomId'] as String?,
      users: json['users'] == null
          ? const []
          : const UserModelConverter().fromJson(json['users'] as Map),
      lastMessage: json['lastMessage'] == null
          ? null
          : Message.fromJson(json['lastMessage'] as Map<String, dynamic>),
      unreadedMessage: (json['unreadedMessage'] as num?)?.toInt() ?? 0,
    );

const _$$ChatRoomImplFieldMap = <String, String>{
  'roomId': 'roomId',
  'users': 'users',
  'lastMessage': 'lastMessage',
  'unreadedMessage': 'unreadedMessage',
};

// ignore: unused_element
abstract class _$$ChatRoomImplPerFieldToJson {
  // ignore: unused_element
  static Object? roomId(String? instance) => instance;
  // ignore: unused_element
  static Object? users(List<UserModel> instance) =>
      const UserModelConverter().toJson(instance);
  // ignore: unused_element
  static Object? lastMessage(Message? instance) => instance;
  // ignore: unused_element
  static Object? unreadedMessage(int instance) => instance;
}

Map<String, dynamic> _$$ChatRoomImplToJson(_$ChatRoomImpl instance) =>
    <String, dynamic>{
      'roomId': instance.roomId,
      'users': const UserModelConverter().toJson(instance.users),
      'lastMessage': instance.lastMessage,
      'unreadedMessage': instance.unreadedMessage,
    };
