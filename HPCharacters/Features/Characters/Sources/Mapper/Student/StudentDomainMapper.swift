import Core
import CharactersDomain
import CharactersData

public class StudentDomainMapper: BaseDomainMapper {
    public init() {}
    
    public func fromDataModelToDomainModel(data: any BaseDataModel) -> any BaseDomainModel {
        let dataModel = data as! StudentModel
        
        return StudentDomainModel(
            id: dataModel.id,
            name: dataModel.name,
            alternateNames: dataModel.alternateNames,
            species: dataModel.species,
            gender: dataModel.gender,
            house: dataModel.house,
            dateOfBirth: dataModel.dateOfBirth,
            yearOfBirth: dataModel.yearOfBirth,
            wizard: dataModel.wizard,
            ancestry: dataModel.ancestry,
            eyeColour: dataModel.eyeColour,
            hairColour: dataModel.hairColour,
            wand: mapWand(wand: dataModel.wand),
            patronus: dataModel.patronus,
            hogwartsStudent: dataModel.hogwartsStudent,
            hogwartsStaff: dataModel.hogwartsStaff,
            actor: dataModel.actor,
            alternateActors: dataModel.alternateActors,
            alive: dataModel.alive,
            image: dataModel.image
        )
    }
    
    private func mapWand(wand: Wand) -> WandDomain {
        return WandDomain(wood: wand.wood, core: wand.core, length: wand.length)
    }
}
