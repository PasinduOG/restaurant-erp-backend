package org.pasinduog.erp.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class MenuItemRequestDto {
    private String name;
    private Boolean isActive;
    private List<MenuItemVariantDto>  variants;
}
