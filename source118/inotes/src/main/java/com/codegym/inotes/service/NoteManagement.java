package com.codegym.inotes.service;

import com.codegym.inotes.model.Note;
import com.codegym.inotes.model.NoteType;
import com.codegym.inotes.strategy.NoteStrategy;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

/**
 * Business logic; the active persistence strategy can be replaced at runtime.
 */
public class NoteManagement {
    private NoteStrategy strategy;

    private static final List<NoteType> TYPES = List.of(
            new NoteType(1, "Cá nhân", "Ghi chú cá nhân"),
            new NoteType(2, "Công việc", "Công việc và cuộc họp"),
            new NoteType(3, "Học tập", "Bài học và nội dung ôn tập")
    );

    public NoteManagement(NoteStrategy strategy) {
        setStrategy(strategy);
    }

    public void setStrategy(NoteStrategy strategy) {
        if (strategy == null) {
            throw new IllegalArgumentException("Strategy không được null.");
        }
        this.strategy = strategy;
    }

    public NoteStrategy getStrategy() {
        return strategy;
    }

    public List<Note> searchNotes(String keyword) throws SQLException, IOException {
        List<Note> notes = strategy.search(keyword);
        fillTypeNames(notes);
        return notes;
    }

    public Note addNote(String title, String content, int typeId) throws SQLException, IOException {
        Note note = new Note(title, content, typeId);
        validate(note);
        note.setStrategy(strategy);
        note.save();
        note.setTypeName(getTypeName(typeId));
        return note;
    }

    public void saveNote(Note note) throws SQLException, IOException {
        validate(note);
        note.setStrategy(strategy);
        note.save();
        note.setTypeName(getTypeName(note.getTypeId()));
    }

    public boolean deleteNote(int id) throws SQLException, IOException {
        Note note = new Note();
        note.setStrategy(strategy);
        return note.delete(id);
    }

    public Note findNoteById(int id) throws SQLException, IOException {
        Note note = strategy.findById(id);
        if (note != null) {
            note.setTypeName(getTypeName(note.getTypeId()));
        }
        return note;
    }

    public List<NoteType> getAvailableTypes() {
        return TYPES;
    }

    public String getTypeName(int typeId) {
        return TYPES.stream()
                .filter(type -> type.getId() == typeId)
                .map(NoteType::getName)
                .findFirst()
                .orElse("Không xác định");
    }

    public String getStorageMode() {
        return strategy.getName();
    }

    private void fillTypeNames(List<Note> notes) {
        for (Note note : notes) {
            note.setTypeName(getTypeName(note.getTypeId()));
        }
    }

    private void validate(Note note) {
        if (note.getTitle() == null || note.getTitle().isBlank()) {
            throw new IllegalArgumentException("Tiêu đề ghi chú không được để trống.");
        }
        if (note.getTitle().length() > 255) {
            throw new IllegalArgumentException("Tiêu đề tối đa 255 ký tự.");
        }
        if (note.getTypeId() < 1 || note.getTypeId() > 3) {
            throw new IllegalArgumentException("Vui lòng chọn phân loại hợp lệ.");
        }
    }
}