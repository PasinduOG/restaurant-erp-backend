package org.pasinduog.erp.service;

import lombok.RequiredArgsConstructor;
import org.pasinduog.erp.dto.IngredientDTO;
import org.pasinduog.erp.exception.BaseNotFoundException;
import org.pasinduog.erp.mapper.IngredientMapper;
import org.pasinduog.erp.repository.IngredientRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class IngredientServiceImpl implements IngredientService {
    private final IngredientRepository repository;
    private final IngredientMapper mapper;

    @Override
    public List<IngredientDTO> getAll() {
        return repository.findAll().stream().map(mapper::toDto).toList();
    }

    @Override
    public IngredientDTO findById(Long id) {
        return mapper.toDto(repository.findById(id).orElseThrow(
                () -> new BaseNotFoundException("Ingredient not found")
        ));
    }

    @Override
    public boolean createIngredient(IngredientDTO ingredientDTO) {
        return repository.save(mapper.toEntity(ingredientDTO));
    }

    @Override
    public boolean updateIngredient(IngredientDTO ingredientDTO) {
        if (!repository.existsById(ingredientDTO.getId())) throw new BaseNotFoundException("Ingredient not found to update");
        return repository.update(mapper.toEntity(ingredientDTO));
    }

    @Override
    public boolean removeIngredient(Long id) {
        if (!repository.existsById(id)) throw new BaseNotFoundException("Ingredient not found to delete");
        return repository.delete(id);
    }
}
