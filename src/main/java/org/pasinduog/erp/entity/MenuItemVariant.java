package org.pasinduog.erp.entity;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class MenuItemVariant {
    private Long id;
    private String menuItemId;
    private String sizeName;
    private BigDecimal price;
    private Integer prepTimeMins;
    private Boolean isAvailable;
}
