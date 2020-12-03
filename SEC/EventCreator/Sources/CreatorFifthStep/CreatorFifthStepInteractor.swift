import UIKit
import Core
import Networking
import Authentication

protocol CreatorFifthStepInteractorLogic {
    func setParticipantsValue(_ value: Int)
    func changeParticipantsValue(by value: Int)
    func addEvent()
}

protocol CreatorFifthStepDataStore {
    var eventEntity: EventEntity { get }
}

final class CreatorFifthStepInteractor: CreatorFifthStepDataStore {
    
    var eventEntity: EventEntity
    
    // MARK: - Private Properties
    
    private let presenter: CreatorFifthStepPresenterLogic
    private let networkingWorker: NetworkingWorkerProtocol
    private let authenticationWorker: AuthenticationWorkerProtocol
    private let dateHelper: DateHelper
    
    // MARK: - Initializers
    
    init(presenter: CreatorFifthStepPresenterLogic,
         eventEntity: EventEntity,
         networkingWorker: NetworkingWorkerProtocol,
         authenticationWorker: AuthenticationWorkerProtocol,
         dateHelper: DateHelper) {
        self.presenter = presenter
        self.eventEntity = eventEntity
        self.networkingWorker = networkingWorker
        self.authenticationWorker = authenticationWorker
        self.dateHelper = dateHelper
    }
    
    func addNewLocalization() {
        guard let lat = eventEntity.latitude,
              let long = eventEntity.longitude else {
            return
        }
        
        networkingWorker.perform(
            mutation: InsertNewLocalizationMutation(
                latitude: lat,
                longitude: long)) { [weak self] (result) in
            switch result {
            case let .success(result):
                guard let localizationId = result.data?.insertLocalization?.returning.first?.id else { return }
                self?.addNewEvent(localizationId: localizationId)
            case .failure(_):
                // TODO: present error
                return
            }
        }
    }
    
    func addNewEvent(localizationId: String) {
        guard let creatorId = authenticationWorker.user?.uid,
              let sportType = eventEntity.sportType,
              let title = eventEntity.title,
              let maxParticipant = eventEntity.maxParticipants,
              let endDate = eventEntity.endDate,
              let startDate = eventEntity.startDate,
              let description = eventEntity.description else {
            return
        }
        
        networkingWorker.perform(
            mutation: InsertNewEventMutation(
                creator: creatorId,
                type: sportType.rawValue,
                title: title,
                max_participant: maxParticipant,
                localization: localizationId,
                end_date: dateHelper.convertDateToString(endDate, with: DateHelper.Constants.fullDateFormat),
                begin_date: dateHelper.convertDateToString(startDate, with: DateHelper.Constants.fullDateFormat),
                description: description)) { [weak self] (result) in
            switch result {
            case .success(_):
                self?.presenter.presentMainEventList()
            case .failure(_):
                // TODO: present error
                return
            }
        }
    }
}

extension CreatorFifthStepInteractor: CreatorFifthStepInteractorLogic {
    func addEvent() {
        addNewLocalization()
    }
    
    func changeParticipantsValue(by value: Int) {
        let valueRange = 0...500
        
        guard let maxParticipants = eventEntity.maxParticipants,
              valueRange.contains(maxParticipants + value) else {
            presenter.errorLabelIsEnabled(true)
            return
        }
        
        eventEntity.maxParticipants = maxParticipants + value
        guard let updatedMaxParticipants = eventEntity.maxParticipants else { return }
        
        presenter.preapareParticipantValue(updatedMaxParticipants)
    }
    
    func setParticipantsValue(_ value: Int) {
        eventEntity.maxParticipants = value
        
        guard let maxParticipants = eventEntity.maxParticipants else { return }
        
        presenter.preapareParticipantValue(maxParticipants)
    }
}
