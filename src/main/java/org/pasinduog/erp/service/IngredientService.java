package org.pasinduog.erp.service;

import org.pasinduog.erp.dto.IngredientDTO;

import java.util.List;

public interface IngredientService {
    List<IngredientDTO> getAll();
    IngredientDTO findById(Long id);
    boolean createIngredient(IngredientDTO ingredientDTO);
    boolean updateIngredient(IngredientDTO ingredientDTO);
    boolean removeIngredient(Long id);
}
