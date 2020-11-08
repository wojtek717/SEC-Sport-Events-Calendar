// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

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
    query GetAllEvents {
      Events(order_by: {begin_date: asc}) {
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
            GraphQLField("name", type: .nonNull(.scalar(String.self))),
            GraphQLField("surname", type: .nonNull(.scalar(String.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(name: String, surname: String) {
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

        public var name: String {
          get {
            return resultMap["name"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }

        public var surname: String {
          get {
            return resultMap["surname"]! as! String
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
