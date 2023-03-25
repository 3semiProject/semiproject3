package org.sixpack.semi.common;

import lombok.*;
//import org.springframework.stereotype.Component;

import java.io.Serializable;
import java.sql.Date;

@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
@ToString

//@Component("searchDate")
public class SearchDate implements Serializable {

    private static final long serialVersionUID = 2253546582582684455L;

    private Date begin;
    private Date end;
}