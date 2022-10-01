@RestResource (urlMapping='/myFirstApexRest')
global class MyFirstApexRest {

    @HttpPost
    global static Account doPost(String name) {
        Account account = new Account();
        account.Name = name;
        insert account;
        return account;
    }
    
    @HttpGet
    global static Account doGet() {
        Account account = new Account();
        account.Name = 'MethodGet';
        insert account;
        return account;
    }
}