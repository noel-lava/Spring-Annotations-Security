package com.jlava.exception;

public class InvalidStringException extends Exception{
	public InvalidStringException() {
		super("Invalid Value");
	}

	public InvalidStringException(String message) {
		super(message);
	}
}