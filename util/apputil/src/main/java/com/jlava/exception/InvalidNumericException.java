package com.jlava.exception;

public class InvalidNumericException extends Exception{
	public InvalidNumericException() {
		super("Invalid Value");
	}

	public InvalidNumericException(String message) {
		super(message);
	}
}