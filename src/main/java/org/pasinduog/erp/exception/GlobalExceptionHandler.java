package org.pasinduog.erp.exception;

import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@RestControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(RuntimeException.class)
    public String handleRuntimeExceptions(RuntimeException ex) {
        return ex.getMessage();
    }

    @ExceptionHandler(BaseNotFoundException.class)
    public String handleBaseNotFoundException(BaseNotFoundException ex) {
        return ex.getMessage();
    }
}
