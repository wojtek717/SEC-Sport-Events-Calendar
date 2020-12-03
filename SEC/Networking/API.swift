// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class DeleteEventParticipantMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation DeleteEventParticipant($userId: String, $eventId: uuid) {
      delete_Events_participants(where: {User: {uuid: {_eq: $userId}}, Event: {id: {_eq: $eventId}}}) {
        __typename
        affected_rows
      }
    }
    """

  public let operationName: String = "DeleteEventParticipant"

  public var userId: String?
  public var eventId: String?

  public init(userId: String? = nil, eventId: String? = nil) {
    self.userId = userId
    self.eventId = eventId
  }

  public var variables: GraphQLMap? {
    return ["userId": userId, "eventId": eventId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["mutation_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("delete_Events_participants", arguments: ["where": ["User": ["uuid": ["_eq": GraphQLVariable("userId")]], "Event": ["id": ["_eq": GraphQLVariable("eventId")]]]], type: .object(DeleteEventsParticipant.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(deleteEventsParticipants: DeleteEventsParticipant? = nil) {
      self.init(unsafeResultMap: ["__typename": "mutation_root", "delete_Events_participants": deleteEventsParticipants.flatMap { (value: DeleteEventsParticipant) -> ResultMap in value.resultMap }])
    }

    /// delete data from the table: "Events_participants"
    public var deleteEventsParticipants: DeleteEventsParticipant? {
      get {
        return (resultMap["delete_Events_participants"] as? ResultMap).flatMap { DeleteEventsParticipant(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "delete_Events_participants")
      }
    }

    public struct DeleteEventsParticipant: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Events_participants_mutation_response"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("affected_rows", type: .nonNull(.scalar(Int.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(affectedRows: Int) {
        self.init(unsafeResultMap: ["__typename": "Events_participants_mutation_response", "affected_rows": affectedRows])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// number of affected rows by the mutation
      public var affectedRows: Int {
        get {
          return resultMap["affected_rows"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "affected_rows")
        }
      }
    }
  }
}

public final class GetEventsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetEvents {
      Events(order_by: {begin_date: asc}) {
        __typename
        title
        description
        max_participant
      }
    }
    """

  public let operationName: String = "GetEvents"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("Events", arguments: ["order_by": ["begin_date": "asc"]], type: .nonNull(.list(.nonNull(.object(Event.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(events: [Event]) {
      self.init(unsafeResultMap: ["__typename": "query_root", "Events": events.map { (value: Event) -> ResultMap in value.resultMap }])
    }

    /// fetch data from the table: "Events"
    public var events: [Event] {
      get {
        return (resultMap["Events"] as! [ResultMap]).map { (value: ResultMap) -> Event in Event(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: Event) -> ResultMap in value.resultMap }, forKey: "Events")
      }
    }

    public struct Event: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Events"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("title", type: .nonNull(.scalar(String.self))),
          GraphQLField("description", type: .nonNull(.scalar(String.self))),
          GraphQLField("max_participant", type: .scalar(Int.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(title: String, description: String, maxParticipant: Int? = nil) {
        self.init(unsafeResultMap: ["__typename": "Events", "title": title, "description": description, "max_participant": maxParticipant])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var title: String {
        get {
          return resultMap["title"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "title")
        }
      }

      public var description: String {
        get {
          return resultMap["description"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "description")
        }
      }

      public var maxParticipant: Int? {
        get {
          return resultMap["max_participant"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "max_participant")
        }
      }
    }
  }
}

public final class GetAllEventsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetAllEvents($sportTypes: [Int!]) {
      Events(order_by: {begin_date: asc}, where: {type: {_in: $sportTypes}}) {
        __typename
        id
        title
        description
        begin_date
        end_date
        max_participant
        type
        Localization {
          __typename
          latitude
          longitude
        }
        Creator {
          __typename
          name
          surname
        }
        Events_participants_aggregate {
          __typename
          aggregate {
            __typename
            count
          }
        }
      }
    }
    """

  public let operationName: String = "GetAllEvents"

  public var sportTypes: [Int]?

  public init(sportTypes: [Int]?) {
    self.sportTypes = sportTypes
  }

  public var variables: GraphQLMap? {
    return ["sportTypes": sportTypes]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("Events", arguments: ["order_by": ["begin_date": "asc"], "where": ["type": ["_in": GraphQLVariable("sportTypes")]]], type: .nonNull(.list(.nonNull(.object(Event.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(events: [Event]) {
      self.init(unsafeResultMap: ["__typename": "query_root", "Events": events.map { (value: Event) -> ResultMap in value.resultMap }])
    }

    /// fetch data from the table: "Events"
    public var events: [Event] {
      get {
        return (resultMap["Events"] as! [ResultMap]).map { (value: ResultMap) -> Event in Event(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: Event) -> ResultMap in value.resultMap }, forKey: "Events")
      }
    }

    public struct Event: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Events"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(String.self))),
          GraphQLField("title", type: .nonNull(.scalar(String.self))),
          GraphQLField("description", type: .nonNull(.scalar(String.self))),
          GraphQLField("begin_date", type: .nonNull(.scalar(String.self))),
          GraphQLField("end_date", type: .nonNull(.scalar(String.self))),
          GraphQLField("max_participant", type: .scalar(Int.self)),
          GraphQLField("type", type: .nonNull(.scalar(Int.self))),
          GraphQLField("Localization", type: .nonNull(.object(Localization.selections))),
          GraphQLField("Creator", type: .nonNull(.object(Creator.selections))),
          GraphQLField("Events_participants_aggregate", type: .nonNull(.object(EventsParticipantsAggregate.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: String, title: String, description: String, beginDate: String, endDate: String, maxParticipant: Int? = nil, type: Int, localization: Localization, creator: Creator, eventsParticipantsAggregate: EventsParticipantsAggregate) {
        self.init(unsafeResultMap: ["__typename": "Events", "id": id, "title": title, "description": description, "begin_date": beginDate, "end_date": endDate, "max_participant": maxParticipant, "type": type, "Localization": localization.resultMap, "Creator": creator.resultMap, "Events_participants_aggregate": eventsParticipantsAggregate.resultMap])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: String {
        get {
          return resultMap["id"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var title: String {
        get {
          return resultMap["title"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "title")
        }
      }

      public var description: String {
        get {
          return resultMap["description"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "description")
        }
      }

      public var beginDate: String {
        get {
          return resultMap["begin_date"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "begin_date")
        }
      }

      public var endDate: String {
        get {
          return resultMap["end_date"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "end_date")
        }
      }

      public var maxParticipant: Int? {
        get {
          return resultMap["max_participant"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "max_participant")
        }
      }

      public var type: Int {
        get {
          return resultMap["type"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "type")
        }
      }

      /// An object relationship
      public var localization: Localization {
        get {
          return Localization(unsafeResultMap: resultMap["Localization"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "Localization")
        }
      }

      /// An object relationship
      public var creator: Creator {
        get {
          return Creator(unsafeResultMap: resultMap["Creator"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "Creator")
        }
      }

      /// An aggregated array relationship
      public var eventsParticipantsAggregate: EventsParticipantsAggregate {
        get {
          return EventsParticipantsAggregate(unsafeResultMap: resultMap["Events_participants_aggregate"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "Events_participants_aggregate")
        }
      }

      public struct Localization: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Localization"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("latitude", type: .nonNull(.scalar(Double.self))),
            GraphQLField("longitude", type: .nonNull(.scalar(Double.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(latitude: Double, longitude: Double) {
          self.init(unsafeResultMap: ["__typename": "Localization", "latitude": latitude, "longitude": longitude])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var latitude: Double {
          get {
            return resultMap["latitude"]! as! Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "latitude")
          }
        }

        public var longitude: Double {
          get {
            return resultMap["longitude"]! as! Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "longitude")
          }
        }
      }

      public struct Creator: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Users"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("name", type: .scalar(String.self)),
            GraphQLField("surname", type: .scalar(String.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(name: String? = nil, surname: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "Users", "name": name, "surname": surname])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var name: String? {
          get {
            return resultMap["name"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }

        public var surname: String? {
          get {
            return resultMap["surname"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "surname")
          }
        }
      }

      public struct EventsParticipantsAggregate: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Events_participants_aggregate"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("aggregate", type: .object(Aggregate.selections)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(aggregate: Aggregate? = nil) {
          self.init(unsafeResultMap: ["__typename": "Events_participants_aggregate", "aggregate": aggregate.flatMap { (value: Aggregate) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var aggregate: Aggregate? {
          get {
            return (resultMap["aggregate"] as? ResultMap).flatMap { Aggregate(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "aggregate")
          }
        }

        public struct Aggregate: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Events_participants_aggregate_fields"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("count", type: .scalar(Int.self)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(count: Int? = nil) {
            self.init(unsafeResultMap: ["__typename": "Events_participants_aggregate_fields", "count": count])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var count: Int? {
            get {
              return resultMap["count"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "count")
            }
          }
        }
      }
    }
  }
}

public final class GetEventQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetEvent($id: uuid) {
      Events(where: {id: {_eq: $id}}) {
        __typename
        title
        description
        type
        begin_date
        end_date
        max_participant
        Events_participants_aggregate {
          __typename
          aggregate {
            __typename
            count
          }
        }
        Localization {
          __typename
          latitude
          longitude
        }
        Creator {
          __typename
          name
          surname
        }
      }
    }
    """

  public let operationName: String = "GetEvent"

  public var id: String?

  public init(id: String? = nil) {
    self.id = id
  }

  public var variables: GraphQLMap? {
    return ["id": id]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("Events", arguments: ["where": ["id": ["_eq": GraphQLVariable("id")]]], type: .nonNull(.list(.nonNull(.object(Event.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(events: [Event]) {
      self.init(unsafeResultMap: ["__typename": "query_root", "Events": events.map { (value: Event) -> ResultMap in value.resultMap }])
    }

    /// fetch data from the table: "Events"
    public var events: [Event] {
      get {
        return (resultMap["Events"] as! [ResultMap]).map { (value: ResultMap) -> Event in Event(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: Event) -> ResultMap in value.resultMap }, forKey: "Events")
      }
    }

    public struct Event: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Events"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("title", type: .nonNull(.scalar(String.self))),
          GraphQLField("description", type: .nonNull(.scalar(String.self))),
          GraphQLField("type", type: .nonNull(.scalar(Int.self))),
          GraphQLField("begin_date", type: .nonNull(.scalar(String.self))),
          GraphQLField("end_date", type: .nonNull(.scalar(String.self))),
          GraphQLField("max_participant", type: .scalar(Int.self)),
          GraphQLField("Events_participants_aggregate", type: .nonNull(.object(EventsParticipantsAggregate.selections))),
          GraphQLField("Localization", type: .nonNull(.object(Localization.selections))),
          GraphQLField("Creator", type: .nonNull(.object(Creator.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(title: String, description: String, type: Int, beginDate: String, endDate: String, maxParticipant: Int? = nil, eventsParticipantsAggregate: EventsParticipantsAggregate, localization: Localization, creator: Creator) {
        self.init(unsafeResultMap: ["__typename": "Events", "title": title, "description": description, "type": type, "begin_date": beginDate, "end_date": endDate, "max_participant": maxParticipant, "Events_participants_aggregate": eventsParticipantsAggregate.resultMap, "Localization": localization.resultMap, "Creator": creator.resultMap])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var title: String {
        get {
          return resultMap["title"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "title")
        }
      }

      public var description: String {
        get {
          return resultMap["description"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "description")
        }
      }

      public var type: Int {
        get {
          return resultMap["type"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "type")
        }
      }

      public var beginDate: String {
        get {
          return resultMap["begin_date"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "begin_date")
        }
      }

      public var endDate: String {
        get {
          return resultMap["end_date"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "end_date")
        }
      }

      public var maxParticipant: Int? {
        get {
          return resultMap["max_participant"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "max_participant")
        }
      }

      /// An aggregated array relationship
      public var eventsParticipantsAggregate: EventsParticipantsAggregate {
        get {
          return EventsParticipantsAggregate(unsafeResultMap: resultMap["Events_participants_aggregate"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "Events_participants_aggregate")
        }
      }

      /// An object relationship
      public var localization: Localization {
        get {
          return Localization(unsafeResultMap: resultMap["Localization"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "Localization")
        }
      }

      /// An object relationship
      public var creator: Creator {
        get {
          return Creator(unsafeResultMap: resultMap["Creator"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "Creator")
        }
      }

      public struct EventsParticipantsAggregate: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Events_participants_aggregate"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("aggregate", type: .object(Aggregate.selections)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(aggregate: Aggregate? = nil) {
          self.init(unsafeResultMap: ["__typename": "Events_participants_aggregate", "aggregate": aggregate.flatMap { (value: Aggregate) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var aggregate: Aggregate? {
          get {
            return (resultMap["aggregate"] as? ResultMap).flatMap { Aggregate(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "aggregate")
          }
        }

        public struct Aggregate: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Events_participants_aggregate_fields"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("count", type: .scalar(Int.self)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(count: Int? = nil) {
            self.init(unsafeResultMap: ["__typename": "Events_participants_aggregate_fields", "count": count])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var count: Int? {
            get {
              return resultMap["count"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "count")
            }
          }
        }
      }

      public struct Localization: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Localization"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("latitude", type: .nonNull(.scalar(Double.self))),
            GraphQLField("longitude", type: .nonNull(.scalar(Double.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(latitude: Double, longitude: Double) {
          self.init(unsafeResultMap: ["__typename": "Localization", "latitude": latitude, "longitude": longitude])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var latitude: Double {
          get {
            return resultMap["latitude"]! as! Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "latitude")
          }
        }

        public var longitude: Double {
          get {
            return resultMap["longitude"]! as! Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "longitude")
          }
        }
      }

      public struct Creator: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Users"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("name", type: .scalar(String.self)),
            GraphQLField("surname", type: .scalar(String.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(name: String? = nil, surname: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "Users", "name": name, "surname": surname])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var name: String? {
          get {
            return resultMap["name"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }

        public var surname: String? {
          get {
            return resultMap["surname"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "surname")
          }
        }
      }
    }
  }
}

public final class GetEventsAroundQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetEventsAround($sportTypes: [Int!], $latLte: Float, $latGte: Float, $longLte: Float, $longGte: Float) {
      Events(order_by: {begin_date: asc}, where: {type: {_in: $sportTypes}, Localization: {latitude: {_lte: $latLte, _gte: $latGte}, longitude: {_lte: $longLte, _gte: $longGte}}}) {
        __typename
        id
        title
        description
        begin_date
        end_date
        max_participant
        type
        Localization {
          __typename
          latitude
          longitude
        }
        Creator {
          __typename
          name
          surname
        }
        Events_participants_aggregate {
          __typename
          aggregate {
            __typename
            count
          }
        }
      }
    }
    """

  public let operationName: String = "GetEventsAround"

  public var sportTypes: [Int]?
  public var latLte: Double?
  public var latGte: Double?
  public var longLte: Double?
  public var longGte: Double?

  public init(sportTypes: [Int]?, latLte: Double? = nil, latGte: Double? = nil, longLte: Double? = nil, longGte: Double? = nil) {
    self.sportTypes = sportTypes
    self.latLte = latLte
    self.latGte = latGte
    self.longLte = longLte
    self.longGte = longGte
  }

  public var variables: GraphQLMap? {
    return ["sportTypes": sportTypes, "latLte": latLte, "latGte": latGte, "longLte": longLte, "longGte": longGte]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("Events", arguments: ["order_by": ["begin_date": "asc"], "where": ["type": ["_in": GraphQLVariable("sportTypes")], "Localization": ["latitude": ["_lte": GraphQLVariable("latLte"), "_gte": GraphQLVariable("latGte")], "longitude": ["_lte": GraphQLVariable("longLte"), "_gte": GraphQLVariable("longGte")]]]], type: .nonNull(.list(.nonNull(.object(Event.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(events: [Event]) {
      self.init(unsafeResultMap: ["__typename": "query_root", "Events": events.map { (value: Event) -> ResultMap in value.resultMap }])
    }

    /// fetch data from the table: "Events"
    public var events: [Event] {
      get {
        return (resultMap["Events"] as! [ResultMap]).map { (value: ResultMap) -> Event in Event(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: Event) -> ResultMap in value.resultMap }, forKey: "Events")
      }
    }

    public struct Event: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Events"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(String.self))),
          GraphQLField("title", type: .nonNull(.scalar(String.self))),
          GraphQLField("description", type: .nonNull(.scalar(String.self))),
          GraphQLField("begin_date", type: .nonNull(.scalar(String.self))),
          GraphQLField("end_date", type: .nonNull(.scalar(String.self))),
          GraphQLField("max_participant", type: .scalar(Int.self)),
          GraphQLField("type", type: .nonNull(.scalar(Int.self))),
          GraphQLField("Localization", type: .nonNull(.object(Localization.selections))),
          GraphQLField("Creator", type: .nonNull(.object(Creator.selections))),
          GraphQLField("Events_participants_aggregate", type: .nonNull(.object(EventsParticipantsAggregate.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: String, title: String, description: String, beginDate: String, endDate: String, maxParticipant: Int? = nil, type: Int, localization: Localization, creator: Creator, eventsParticipantsAggregate: EventsParticipantsAggregate) {
        self.init(unsafeResultMap: ["__typename": "Events", "id": id, "title": title, "description": description, "begin_date": beginDate, "end_date": endDate, "max_participant": maxParticipant, "type": type, "Localization": localization.resultMap, "Creator": creator.resultMap, "Events_participants_aggregate": eventsParticipantsAggregate.resultMap])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: String {
        get {
          return resultMap["id"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var title: String {
        get {
          return resultMap["title"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "title")
        }
      }

      public var description: String {
        get {
          return resultMap["description"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "description")
        }
      }

      public var beginDate: String {
        get {
          return resultMap["begin_date"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "begin_date")
        }
      }

      public var endDate: String {
        get {
          return resultMap["end_date"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "end_date")
        }
      }

      public var maxParticipant: Int? {
        get {
          return resultMap["max_participant"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "max_participant")
        }
      }

      public var type: Int {
        get {
          return resultMap["type"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "type")
        }
      }

      /// An object relationship
      public var localization: Localization {
        get {
          return Localization(unsafeResultMap: resultMap["Localization"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "Localization")
        }
      }

      /// An object relationship
      public var creator: Creator {
        get {
          return Creator(unsafeResultMap: resultMap["Creator"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "Creator")
        }
      }

      /// An aggregated array relationship
      public var eventsParticipantsAggregate: EventsParticipantsAggregate {
        get {
          return EventsParticipantsAggregate(unsafeResultMap: resultMap["Events_participants_aggregate"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "Events_participants_aggregate")
        }
      }

      public struct Localization: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Localization"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("latitude", type: .nonNull(.scalar(Double.self))),
            GraphQLField("longitude", type: .nonNull(.scalar(Double.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(latitude: Double, longitude: Double) {
          self.init(unsafeResultMap: ["__typename": "Localization", "latitude": latitude, "longitude": longitude])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var latitude: Double {
          get {
            return resultMap["latitude"]! as! Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "latitude")
          }
        }

        public var longitude: Double {
          get {
            return resultMap["longitude"]! as! Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "longitude")
          }
        }
      }

      public struct Creator: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Users"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("name", type: .scalar(String.self)),
            GraphQLField("surname", type: .scalar(String.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(name: String? = nil, surname: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "Users", "name": name, "surname": surname])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var name: String? {
          get {
            return resultMap["name"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }

        public var surname: String? {
          get {
            return resultMap["surname"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "surname")
          }
        }
      }

      public struct EventsParticipantsAggregate: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Events_participants_aggregate"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("aggregate", type: .object(Aggregate.selections)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(aggregate: Aggregate? = nil) {
          self.init(unsafeResultMap: ["__typename": "Events_participants_aggregate", "aggregate": aggregate.flatMap { (value: Aggregate) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var aggregate: Aggregate? {
          get {
            return (resultMap["aggregate"] as? ResultMap).flatMap { Aggregate(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "aggregate")
          }
        }

        public struct Aggregate: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Events_participants_aggregate_fields"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("count", type: .scalar(Int.self)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(count: Int? = nil) {
            self.init(unsafeResultMap: ["__typename": "Events_participants_aggregate_fields", "count": count])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var count: Int? {
            get {
              return resultMap["count"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "count")
            }
          }
        }
      }
    }
  }
}

public final class GetUserQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetUser($uuid: String!) {
      Users(where: {uuid: {_eq: $uuid}}) {
        __typename
        name
        surname
        uuid
      }
    }
    """

  public let operationName: String = "GetUser"

  public var uuid: String

  public init(uuid: String) {
    self.uuid = uuid
  }

  public var variables: GraphQLMap? {
    return ["uuid": uuid]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("Users", arguments: ["where": ["uuid": ["_eq": GraphQLVariable("uuid")]]], type: .nonNull(.list(.nonNull(.object(User.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(users: [User]) {
      self.init(unsafeResultMap: ["__typename": "query_root", "Users": users.map { (value: User) -> ResultMap in value.resultMap }])
    }

    /// fetch data from the table: "Users"
    public var users: [User] {
      get {
        return (resultMap["Users"] as! [ResultMap]).map { (value: ResultMap) -> User in User(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: User) -> ResultMap in value.resultMap }, forKey: "Users")
      }
    }

    public struct User: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Users"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .scalar(String.self)),
          GraphQLField("surname", type: .scalar(String.self)),
          GraphQLField("uuid", type: .nonNull(.scalar(String.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(name: String? = nil, surname: String? = nil, uuid: String) {
        self.init(unsafeResultMap: ["__typename": "Users", "name": name, "surname": surname, "uuid": uuid])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var name: String? {
        get {
          return resultMap["name"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      public var surname: String? {
        get {
          return resultMap["surname"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "surname")
        }
      }

      public var uuid: String {
        get {
          return resultMap["uuid"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "uuid")
        }
      }
    }
  }
}

public final class InsertEventsParticipantsMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation InsertEventsParticipants($eventId: uuid, $userId: String, $id: String) {
      insert_Events_participants_one(object: {event_id: $eventId, user_id: $userId, id: $id}) {
        __typename
        event_id
        id
        user_id
      }
    }
    """

  public let operationName: String = "InsertEventsParticipants"

  public var eventId: String?
  public var userId: String?
  public var id: String?

  public init(eventId: String? = nil, userId: String? = nil, id: String? = nil) {
    self.eventId = eventId
    self.userId = userId
    self.id = id
  }

  public var variables: GraphQLMap? {
    return ["eventId": eventId, "userId": userId, "id": id]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["mutation_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("insert_Events_participants_one", arguments: ["object": ["event_id": GraphQLVariable("eventId"), "user_id": GraphQLVariable("userId"), "id": GraphQLVariable("id")]], type: .object(InsertEventsParticipantsOne.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(insertEventsParticipantsOne: InsertEventsParticipantsOne? = nil) {
      self.init(unsafeResultMap: ["__typename": "mutation_root", "insert_Events_participants_one": insertEventsParticipantsOne.flatMap { (value: InsertEventsParticipantsOne) -> ResultMap in value.resultMap }])
    }

    /// insert a single row into the table: "Events_participants"
    public var insertEventsParticipantsOne: InsertEventsParticipantsOne? {
      get {
        return (resultMap["insert_Events_participants_one"] as? ResultMap).flatMap { InsertEventsParticipantsOne(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "insert_Events_participants_one")
      }
    }

    public struct InsertEventsParticipantsOne: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Events_participants"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("event_id", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(String.self))),
          GraphQLField("user_id", type: .nonNull(.scalar(String.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(eventId: String, id: String, userId: String) {
        self.init(unsafeResultMap: ["__typename": "Events_participants", "event_id": eventId, "id": id, "user_id": userId])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var eventId: String {
        get {
          return resultMap["event_id"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "event_id")
        }
      }

      /// eventId+UserId
      public var id: String {
        get {
          return resultMap["id"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var userId: String {
        get {
          return resultMap["user_id"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "user_id")
        }
      }
    }
  }
}

public final class InsertNewEventMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation InsertNewEvent($creator: String, $type: Int, $title: String, $max_participant: Int, $localization: uuid, $end_date: timestamptz, $begin_date: timestamptz, $description: String) {
      insert_Events(objects: {creator: $creator, description: $description, begin_date: $begin_date, end_date: $end_date, localization: $localization, max_participant: $max_participant, title: $title, type: $type}) {
        __typename
        returning {
          __typename
          id
        }
      }
    }
    """

  public let operationName: String = "InsertNewEvent"

  public var creator: String?
  public var type: Int?
  public var title: String?
  public var max_participant: Int?
  public var localization: String?
  public var end_date: String?
  public var begin_date: String?
  public var description: String?

  public init(creator: String? = nil, type: Int? = nil, title: String? = nil, max_participant: Int? = nil, localization: String? = nil, end_date: String? = nil, begin_date: String? = nil, description: String? = nil) {
    self.creator = creator
    self.type = type
    self.title = title
    self.max_participant = max_participant
    self.localization = localization
    self.end_date = end_date
    self.begin_date = begin_date
    self.description = description
  }

  public var variables: GraphQLMap? {
    return ["creator": creator, "type": type, "title": title, "max_participant": max_participant, "localization": localization, "end_date": end_date, "begin_date": begin_date, "description": description]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["mutation_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("insert_Events", arguments: ["objects": ["creator": GraphQLVariable("creator"), "description": GraphQLVariable("description"), "begin_date": GraphQLVariable("begin_date"), "end_date": GraphQLVariable("end_date"), "localization": GraphQLVariable("localization"), "max_participant": GraphQLVariable("max_participant"), "title": GraphQLVariable("title"), "type": GraphQLVariable("type")]], type: .object(InsertEvent.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(insertEvents: InsertEvent? = nil) {
      self.init(unsafeResultMap: ["__typename": "mutation_root", "insert_Events": insertEvents.flatMap { (value: InsertEvent) -> ResultMap in value.resultMap }])
    }

    /// insert data into the table: "Events"
    public var insertEvents: InsertEvent? {
      get {
        return (resultMap["insert_Events"] as? ResultMap).flatMap { InsertEvent(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "insert_Events")
      }
    }

    public struct InsertEvent: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Events_mutation_response"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("returning", type: .nonNull(.list(.nonNull(.object(Returning.selections))))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(returning: [Returning]) {
        self.init(unsafeResultMap: ["__typename": "Events_mutation_response", "returning": returning.map { (value: Returning) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// data of the affected rows by the mutation
      public var returning: [Returning] {
        get {
          return (resultMap["returning"] as! [ResultMap]).map { (value: ResultMap) -> Returning in Returning(unsafeResultMap: value) }
        }
        set {
          resultMap.updateValue(newValue.map { (value: Returning) -> ResultMap in value.resultMap }, forKey: "returning")
        }
      }

      public struct Returning: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Events"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(String.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: String) {
          self.init(unsafeResultMap: ["__typename": "Events", "id": id])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: String {
          get {
            return resultMap["id"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }
      }
    }
  }
}

public final class InsertNewLocalizationMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation InsertNewLocalization($latitude: Float, $longitude: Float) {
      insert_Localization(objects: {latitude: $latitude, longitude: $longitude}) {
        __typename
        returning {
          __typename
          id
        }
      }
    }
    """

  public let operationName: String = "InsertNewLocalization"

  public var latitude: Double?
  public var longitude: Double?

  public init(latitude: Double? = nil, longitude: Double? = nil) {
    self.latitude = latitude
    self.longitude = longitude
  }

  public var variables: GraphQLMap? {
    return ["latitude": latitude, "longitude": longitude]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["mutation_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("insert_Localization", arguments: ["objects": ["latitude": GraphQLVariable("latitude"), "longitude": GraphQLVariable("longitude")]], type: .object(InsertLocalization.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(insertLocalization: InsertLocalization? = nil) {
      self.init(unsafeResultMap: ["__typename": "mutation_root", "insert_Localization": insertLocalization.flatMap { (value: InsertLocalization) -> ResultMap in value.resultMap }])
    }

    /// insert data into the table: "Localization"
    public var insertLocalization: InsertLocalization? {
      get {
        return (resultMap["insert_Localization"] as? ResultMap).flatMap { InsertLocalization(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "insert_Localization")
      }
    }

    public struct InsertLocalization: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Localization_mutation_response"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("returning", type: .nonNull(.list(.nonNull(.object(Returning.selections))))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(returning: [Returning]) {
        self.init(unsafeResultMap: ["__typename": "Localization_mutation_response", "returning": returning.map { (value: Returning) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// data of the affected rows by the mutation
      public var returning: [Returning] {
        get {
          return (resultMap["returning"] as! [ResultMap]).map { (value: ResultMap) -> Returning in Returning(unsafeResultMap: value) }
        }
        set {
          resultMap.updateValue(newValue.map { (value: Returning) -> ResultMap in value.resultMap }, forKey: "returning")
        }
      }

      public struct Returning: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Localization"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(String.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: String) {
          self.init(unsafeResultMap: ["__typename": "Localization", "id": id])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: String {
          get {
            return resultMap["id"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }
      }
    }
  }
}

public final class InsertNewUserQueryMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation InsertNewUserQuery($uuid: String) {
      insert_Users(objects: {uuid: $uuid}) {
        __typename
        affected_rows
      }
    }
    """

  public let operationName: String = "InsertNewUserQuery"

  public var uuid: String?

  public init(uuid: String? = nil) {
    self.uuid = uuid
  }

  public var variables: GraphQLMap? {
    return ["uuid": uuid]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["mutation_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("insert_Users", arguments: ["objects": ["uuid": GraphQLVariable("uuid")]], type: .object(InsertUser.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(insertUsers: InsertUser? = nil) {
      self.init(unsafeResultMap: ["__typename": "mutation_root", "insert_Users": insertUsers.flatMap { (value: InsertUser) -> ResultMap in value.resultMap }])
    }

    /// insert data into the table: "Users"
    public var insertUsers: InsertUser? {
      get {
        return (resultMap["insert_Users"] as? ResultMap).flatMap { InsertUser(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "insert_Users")
      }
    }

    public struct InsertUser: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Users_mutation_response"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("affected_rows", type: .nonNull(.scalar(Int.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(affectedRows: Int) {
        self.init(unsafeResultMap: ["__typename": "Users_mutation_response", "affected_rows": affectedRows])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// number of affected rows by the mutation
      public var affectedRows: Int {
        get {
          return resultMap["affected_rows"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "affected_rows")
        }
      }
    }
  }
}

public final class IsSignedUpQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query IsSignedUp($userId: String, $eventId: uuid) {
      Events_participants(where: {User: {uuid: {_eq: $userId}}, Event: {id: {_eq: $eventId}}}) {
        __typename
        id
        event_id
        user_id
      }
    }
    """

  public let operationName: String = "IsSignedUp"

  public var userId: String?
  public var eventId: String?

  public init(userId: String? = nil, eventId: String? = nil) {
    self.userId = userId
    self.eventId = eventId
  }

  public var variables: GraphQLMap? {
    return ["userId": userId, "eventId": eventId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("Events_participants", arguments: ["where": ["User": ["uuid": ["_eq": GraphQLVariable("userId")]], "Event": ["id": ["_eq": GraphQLVariable("eventId")]]]], type: .nonNull(.list(.nonNull(.object(EventsParticipant.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(eventsParticipants: [EventsParticipant]) {
      self.init(unsafeResultMap: ["__typename": "query_root", "Events_participants": eventsParticipants.map { (value: EventsParticipant) -> ResultMap in value.resultMap }])
    }

    /// fetch data from the table: "Events_participants"
    public var eventsParticipants: [EventsParticipant] {
      get {
        return (resultMap["Events_participants"] as! [ResultMap]).map { (value: ResultMap) -> EventsParticipant in EventsParticipant(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: EventsParticipant) -> ResultMap in value.resultMap }, forKey: "Events_participants")
      }
    }

    public struct EventsParticipant: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Events_participants"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(String.self))),
          GraphQLField("event_id", type: .nonNull(.scalar(String.self))),
          GraphQLField("user_id", type: .nonNull(.scalar(String.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: String, eventId: String, userId: String) {
        self.init(unsafeResultMap: ["__typename": "Events_participants", "id": id, "event_id": eventId, "user_id": userId])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// eventId+UserId
      public var id: String {
        get {
          return resultMap["id"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var eventId: String {
        get {
          return resultMap["event_id"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "event_id")
        }
      }

      public var userId: String {
        get {
          return resultMap["user_id"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "user_id")
        }
      }
    }
  }
}

public final class UpdateUserQueryMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation UpdateUserQuery($uuid: String!, $name: String, $surname: String) {
      update_Users(where: {uuid: {_eq: $uuid}}, _set: {name: $name, surname: $surname}) {
        __typename
        returning {
          __typename
          name
          surname
          uuid
        }
      }
    }
    """

  public let operationName: String = "UpdateUserQuery"

  public var uuid: String
  public var name: String?
  public var surname: String?

  public init(uuid: String, name: String? = nil, surname: String? = nil) {
    self.uuid = uuid
    self.name = name
    self.surname = surname
  }

  public var variables: GraphQLMap? {
    return ["uuid": uuid, "name": name, "surname": surname]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["mutation_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("update_Users", arguments: ["where": ["uuid": ["_eq": GraphQLVariable("uuid")]], "_set": ["name": GraphQLVariable("name"), "surname": GraphQLVariable("surname")]], type: .object(UpdateUser.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(updateUsers: UpdateUser? = nil) {
      self.init(unsafeResultMap: ["__typename": "mutation_root", "update_Users": updateUsers.flatMap { (value: UpdateUser) -> ResultMap in value.resultMap }])
    }

    /// update data of the table: "Users"
    public var updateUsers: UpdateUser? {
      get {
        return (resultMap["update_Users"] as? ResultMap).flatMap { UpdateUser(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "update_Users")
      }
    }

    public struct UpdateUser: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Users_mutation_response"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("returning", type: .nonNull(.list(.nonNull(.object(Returning.selections))))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(returning: [Returning]) {
        self.init(unsafeResultMap: ["__typename": "Users_mutation_response", "returning": returning.map { (value: Returning) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// data of the affected rows by the mutation
      public var returning: [Returning] {
        get {
          return (resultMap["returning"] as! [ResultMap]).map { (value: ResultMap) -> Returning in Returning(unsafeResultMap: value) }
        }
        set {
          resultMap.updateValue(newValue.map { (value: Returning) -> ResultMap in value.resultMap }, forKey: "returning")
        }
      }

      public struct Returning: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Users"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("name", type: .scalar(String.self)),
            GraphQLField("surname", type: .scalar(String.self)),
            GraphQLField("uuid", type: .nonNull(.scalar(String.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(name: String? = nil, surname: String? = nil, uuid: String) {
          self.init(unsafeResultMap: ["__typename": "Users", "name": name, "surname": surname, "uuid": uuid])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var name: String? {
          get {
            return resultMap["name"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }

        public var surname: String? {
          get {
            return resultMap["surname"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "surname")
          }
        }

        public var uuid: String {
          get {
            return resultMap["uuid"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "uuid")
          }
        }
      }
    }
  }
}
