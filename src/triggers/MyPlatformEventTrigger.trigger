trigger MyPlatformEventTrigger on MyPlatformEvent__e (after insert) {
    System.debug('Сработал MyPlatformEventTrigger');
    // Получаем лида с именеи ForExperiment
    Lead myLead = [SELECT Id, Name, Phone FROM Lead WHERE Id = '00Q5g000005nGISEA2'];
    myLead.Phone = '565657';
    update myLead;
}