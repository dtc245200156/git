package com.codegym.inotes.strategy;

import com.codegym.inotes.model.Note;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

/**
 * Strategy contract for note persistence.
 */
public interface NoteStrategy {
    void save(Note note) throws SQLException, IOException;

    boolean delete(int id) throws SQLException, IOException;

    List<Note> findAll() throws SQLException, IOException;

    List<Note> search(String keyword) throws SQLException, IOException;

    Note findById(int id) throws SQLException, IOException;

    String getName();
}