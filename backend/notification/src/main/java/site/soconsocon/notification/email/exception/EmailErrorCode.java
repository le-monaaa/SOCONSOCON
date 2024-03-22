package site.soconsocon.notification.email.exception;

import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.http.HttpStatus;
import site.soconsocon.utils.exception.CustomError;

@Getter
@AllArgsConstructor
public enum EmailErrorCode implements CustomError {
    DIFFERENT_NUMBER(HttpStatus.BAD_REQUEST,"번호가 다릅니다.","400");

    private HttpStatus httpStatus;
    private final String message;
    private String errorCode;
}
