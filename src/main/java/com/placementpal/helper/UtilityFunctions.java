package com.placementpal.helper;

public class UtilityFunctions {
	
	public static String returnSalary(String sal) {
		String str = sal.substring(0, sal.length()-3);
		Float val = Float.parseFloat(str)*100000;
		int salary = val.intValue();
		return String.valueOf(salary);
		
	}
}
