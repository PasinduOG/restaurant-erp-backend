package org.pasinduog.erp.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class MenuItemVariantDto {
    private String sizeName;
    private BigDecimal price;
    private Integer prepTimeMins;
    private Boolean isAvailable;
    private List<BomEntryDto> bomEntries;
}
