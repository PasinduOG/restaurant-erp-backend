package org.pasinduog.erp.repository;

public interface MenuItemRepository {
    Long saveAndReturnId(String name, boolean isActive);
    List<MenuItem> findAllActive();
    Optional<MenuItem> findById(Long id);
    boolean update(Long id, String name, boolean isActive);
    boolean softDelete(Long id);
}
