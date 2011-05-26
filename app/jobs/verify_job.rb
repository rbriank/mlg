class VerifyJob
  @queue = :verify

  def self.perform(person_id)
    person = Person.find_by_id(person_id)
    person.verify if person
  end
end
