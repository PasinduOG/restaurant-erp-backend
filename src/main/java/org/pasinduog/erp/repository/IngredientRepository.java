package org.pasinduog.erp.repository;

import org.pasinduog.erp.entity.Ingredient;

import java.util.List;
import java.util.Optional;

public interface IngredientRepository {
    List<Ingredient> findAll();
    Optional<Ingredient> findById(Long id);
    boolean save(Ingredient ingredient);
    boolean update(Ingredient ingredient);
    boolean delete(Long id);
    boolean existsById(Long id);
}
