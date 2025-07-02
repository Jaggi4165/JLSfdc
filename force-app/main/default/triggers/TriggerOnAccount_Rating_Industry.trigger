trigger TriggerOnAccount_Rating_Industry on Account (before insert) {
        if(Trigger.isInsert && Trigger.isBefore)
    {
        for(Account a:trigger.new)
        {
            if(a.Industry=='Agriculture'){ a.Rating='Hot'; }
            else if(a.Industry=='Consulting'){ a.Rating='Warm'; }
            else if(a.Industry=='Electronics'){ a.Rating='Cold'; }
            else {a.Rating=NULL ; }
        }
    }
    if(Trigger.isUpdate && Trigger.isBefore)
    {
        for(Account a:trigger.new)
        {
            if(trigger.oldmap.get(a.Id).Industry==NULL)
            {
                if(a.Industry=='Agriculture'){ a.Rating='Hot'; }
                else if(a.Industry=='Consulting'){ a.Rating='Warm'; }
                else if(a.Industry=='Electronics'){ a.Rating='Cold'; }
                else {a.Rating=NULL ; }
            }
            if(trigger.oldmap.get(a.Id).Industry != NULL)
            {
                if(a.Industry=='Agriculture'){ a.Rating='Hot'; }
                else if(a.Industry=='Consulting'){ a.Rating='Warm'; }
                else if(a.Industry=='Electronics'){ a.Rating='Cold'; }
                else {a.Rating=NULL ; }
            }
        if(a.Industry == NULL)
        {
            a.Rating = NULL;
        }
        }
    }
}