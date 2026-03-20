package org.pasinduog.erp.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class IngredientDTO {
    Long id;

    @NotBlank(message = "Name cannot be empty")
    String name;

    @NotBlank(message = "Unit of Measure cannot be empty")
    String unitOfMeasure;

    @NotNull(message = "Unit of Measure cannot be empty")
    @Positive(message = "Unit of Measure should be positive value")
    BigDecimal unitCost;

    @NotNull(message = "Current stock cannot be empty")
    @Positive(message = "Current stock should be positive value")
    BigDecimal currentStock;

    @NotNull(message = "Minimum reorder level cannot be empty")
    @Positive(message = "Minimum reorder level should be positive value")
    BigDecimal minimumReorderLevel;
}