public class Assignment8 {
    public void returnDateTime(){
        DateTime dt = DateTime.now();
        //Return current Date and Time
		System.debug('Current Time : ' + dt);
        // 5 Days from now
        System.debug('5 Days from now : '+dt.addDays(5));
        // 5 Months from now
        System.debug('5 Months from now : '+dt.addMonths(5));
    }
}
/*
trigger TriggerOnAccount_RatingIndustry on Account (before insert,before update) 
{
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
            if(trigger.oldmap(a.Id).Industry != NULL)
            {
                if(a.Industry=='Agriculture'){ a.Rating='Hot'; }
                else if(a.Industry=='Consulting'){ a.Rating='Warm'; }
                else if(a.Industry=='Electronics'){ a.Rating='Cold'; }
                else {a.Rating=NULL ; }
            }
        }
        if(a.Industry == NULL)
        {
            a.Rating = NULL;
        }
    }
}
*/