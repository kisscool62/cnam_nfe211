public class to_tranche_age {
	private enum TRANCHE_AGE{
		LT_12("-12"),
		B12_25("12-25"),
		B25_34("25-34"),
		B35_65("35-65"),
		MT_65("+65");
		
		TRANCHE_AGE(String label){
			this.label = label;
		}
		
		private final String label;
		
	}
	
    public static String perform(int age){
    	String tranche_age = "-12";
    	if(age < 0){throw new IllegalArgumentException("age should not be less than 0: " + age);}
    	if(age < 12){return TRANCHE_AGE.LT_12.label;}
    	if(age >= 12 && age <= 25){return TRANCHE_AGE.B12_25.label;}
    	if(age > 25 && age <= 34){return TRANCHE_AGE.B25_34.label;}
    	if(age > 34 && age <= 65){return TRANCHE_AGE.B35_65.label;}
    	return TRANCHE_AGE.MT_65.label;
    }
}