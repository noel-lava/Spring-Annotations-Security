package com.jlava.apputil;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import org.apache.commons.lang3.*;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;
import org.joda.time.DateTime;

import com.jlava.exception.*;

public class AppUtil{
	static SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    static DateTimeFormatter formatter = DateTimeFormat.forPattern("yyyy-MM-dd");

    public static Integer readInt(String value, int min, int max, boolean acceptNull, String name) throws InvalidNumericException{
		Integer input = null;

		if((value == null || StringUtils.isEmpty(value)) && !acceptNull) {
			throw new InvalidNumericException("Invalid input ("+name+") : required value");
		} else if((value == null || StringUtils.isEmpty(value)) && acceptNull) {
			return new Integer(0);
		}

		try{
			input = Integer.parseInt(value);
			
			if(input < min && input > max) {
				throw new InvalidNumericException("Invalid " + name);
			} 
		}catch(NumberFormatException ime) {
			throw new InvalidNumericException("Invalid " + name);
		}

		return input;
	}

	public static Float readFloat(String value, Float min, Float max, String name) throws InvalidNumericException{
		Float fp = new Float(0);
		try {
			fp = Float.parseFloat(value);

			if(fp < min || fp > max) {
				//print("\n[Invalid input, try again] : ");
				throw new InvalidNumericException(name + " not in range");
			}

			return fp;
		} catch(NumberFormatException nfe) {
			System.out.println("FLOT : " + value);
			throw new InvalidNumericException("Invalid " + name + " : required value");
		} catch(NullPointerException npe) {
            return fp;
        }
	}

    public static String readLine(String value, boolean acceptNull, int length, String name) throws InvalidStringException{
    	if ((value == null || StringUtils.isEmpty(value)) && !acceptNull) {
    		throw new InvalidStringException("Invalid input ("+name+") : required value");
    	} else if ((value == null || StringUtils.isEmpty(value)) && acceptNull) {
    		return null;
    	} else {
    		if(value.length() > length) {
    			throw new InvalidStringException("Input too long - Max input for this field is " + length + "");
    		}
    		return value;
    	}
    }

    public static String readNumeric(String value, boolean acceptNull, int length, String name) throws InvalidNumericException {
    	if ((StringUtils.isEmpty(value) || value == null) && !acceptNull) {
    		throw new InvalidNumericException("Invalid "+name+" : required value");
    	} else if(!StringUtils.isNumeric(value)) {
    		throw new InvalidNumericException("Invalid "+name);
		} else if(value.length() > length || value.length() < length) {
    		throw new InvalidNumericException("Invalid "+name);
        } else {
    		return value;		
		}
    }

    public static boolean readBool(String input) {
        try{
            return (input.equals("true"))? true : false;
        } catch(NullPointerException npe) {
            return false;
        }
    }

    public static Date readDate(String date) {
    	System.out.println("-"+date+"-");
    	try {
    		Date result = dateFormat.parse(date);
    		//Date result = formatter.parseDateTime(date).toDate();
    		return result;
    	} catch (Exception e) {
    		e.printStackTrace();
    		return null;
    	}
    }

    public static Date readDate(String dateString, boolean acceptNull, String name) throws InvalidDateException{
       	Date date = null;
    	Date today = new Date();
    	if(!StringUtils.isEmpty(dateString) && dateString != null) {
    		date = readDate(dateString);
    	} 

    	if(date == null && acceptNull){
    		return null;
		} else if(date == null && !acceptNull) {
			throw new InvalidDateException("Invalid Date (" + name + " - " + dateString + ") : required value");
		} else if(date.after(today)) {
			throw new InvalidDateException("Invalid Date (" + name + ") : Date cannot be after today");
		}

		return date;
    }
}