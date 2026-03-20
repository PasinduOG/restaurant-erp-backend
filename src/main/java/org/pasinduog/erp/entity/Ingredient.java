package org.pasinduog.erp.entity;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Ingredient {
    private Long id;
    private String name;
    private String unitOfMeasure;
    private BigDecimal unitCost;
    private BigDecimal currentStock;
    private BigDecimal minimumReorderLevel;
    private Boolean isStockTracked;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}
