package org.pasinduog.erp.mapper;

import org.mapstruct.Mapper;
import org.pasinduog.erp.dto.IngredientDTO;
import org.pasinduog.erp.entity.Ingredient;

@Mapper(componentModel = "spring")
public interface IngredientMapper {
    IngredientDTO toDto(Ingredient ingredient);
    Ingredient toEntity(IngredientDTO ingredientDto);
}
