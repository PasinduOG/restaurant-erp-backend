package org.pasinduog.erp.repository.impl;

import lombok.RequiredArgsConstructor;
import org.pasinduog.erp.entity.Ingredient;
import org.pasinduog.erp.repository.IngredientRepository;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
@RequiredArgsConstructor
public class IngredientRepositoryImpl implements IngredientRepository {
    private final JdbcTemplate template;

    @Override
    public List<Ingredient> findAll() {
        return template.query("SELECT * FROM ingredients", (rs, rowNum) -> new Ingredient(
                rs.getLong("id"),
                rs.getString("name"),
                rs.getString("unit_of_measure"),
                rs.getBigDecimal("unit_cost"),
                rs.getBigDecimal("current_stock"),
                rs.getBigDecimal("minimum_reorder_level"),
                rs.getTimestamp("created_at").toLocalDateTime(),
                rs.getTimestamp("updated_at").toLocalDateTime()
        ));
    }

    @Override
    public Optional<Ingredient> findById(Long id) {
        try {
            return Optional.ofNullable(template.queryForObject("SELECT * FROM ingredients", (rs, rowNum) -> new Ingredient(
                    rs.getLong("id"),
                    rs.getString("name"),
                    rs.getString("unit_of_measure"),
                    rs.getBigDecimal("unit_cost"),
                    rs.getBigDecimal("current_stock"),
                    rs.getBigDecimal("minimum_reorder_level"),
                    rs.getTimestamp("created_at").toLocalDateTime(),
                    rs.getTimestamp("updated_at").toLocalDateTime()
            )));
        } catch (RuntimeException e) {
            return Optional.empty();
        }
    }

    @Override
    public boolean save(Ingredient ingredient) {
        return template.update("INSERT INTO ingredients (name, unit_of_measure, unit_cost, current_stock, minimum_reorder_level) VALUES (?,?,?,?,?)",
                ingredient.getName(),
                ingredient.getUnitOfMeasure(),
                ingredient.getUnitCost(),
                ingredient.getCurrentStock(),
                ingredient.getMinimumReorderLevel()) > 0;
    }

    @Override
    public boolean update(Ingredient ingredient) {
        return template.update("UPDATE ingredients SET name = ?, unit_of_measure = ?, unit_cost = ?, current_stock = ?, minimum_reorder_level = ? WHERE id = ?",
                ingredient.getName(),
                ingredient.getUnitOfMeasure(),
                ingredient.getUnitCost(),
                ingredient.getCurrentStock(),
                ingredient.getMinimumReorderLevel(),
                ingredient.getId()) > 0;
    }

    @Override
    public boolean delete(Long id) {
        return template.update("DELETE FROM ingredients WHERE id = ?", id) > 0;
    }

    @Override
    public boolean existsById(Long id) {
        return findById(id).isPresent();
    }
}
