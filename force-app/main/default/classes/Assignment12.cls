public class Assignment12 {
   	public void method(Integer data1)
    {
		Integer i=0;
		List<string> print=new List<string>{'#'};
		for(i=0;i<data1-1;i++)
        {
			print.add('#');
		}
		List<string> print2=new List<string>{'#'};
		for(i=0;i<data1-2;i++)
        {
			print2.add(' ');
		}
	print2.add('#');
	string string1 = string.join(print,'');
	string string2 = string.join(print2,' ');
	for(i=0;i<data1;i++)
    {
		if(i<data1-1 && i!=0){
		system.debug(''+string2);
	}
	else
    {
		System.debug(''+string1);
	}
}
}
}