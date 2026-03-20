package org.pasinduog.erp.controller;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.pasinduog.erp.dto.IngredientDTO;
import org.pasinduog.erp.service.IngredientService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/ingredients")
@RequiredArgsConstructor
public class IngredientController {
    private final IngredientService service;

    @GetMapping
    List<IngredientDTO> getAll(){
        return service.getAll();
    }

    @GetMapping("/{id}")
    IngredientDTO findById(@PathVariable Long id){
        return service.findById(id);
    }

    @PostMapping
    boolean createIngredient(@Valid @RequestBody IngredientDTO ingredientDTO) {
        return service.createIngredient(ingredientDTO);
    }

    @PutMapping("/{id}")
    boolean updateIngredient(@Valid @RequestBody IngredientDTO ingredientDTO) {
        return service.updateIngredient(ingredientDTO);
    }

    @DeleteMapping("/{id}")
    boolean removeIngredient(@PathVariable Long id) {
        return service.removeIngredient(id);
    }
}
