package com.codegym.inotes.model;

import com.codegym.inotes.strategy.NoteStrategy;

import java.io.IOException;
import java.sql.SQLException;

/**
 * Model for a personal note. Persistence is delegated to the selected strategy.
 */
public class Note {
    private int id;
    private String title;
    private String content;
    private int typeId;
    private String typeName;
    private transient NoteStrategy strategy;

    public Note() {
    }

    public Note(int id, String title, String content, int typeId) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.typeId = typeId;
    }

    public Note(String title, String content, int typeId) {
        this(0, title, content, typeId);
    }

    public void setStrategy(NoteStrategy strategy) {
        this.strategy = strategy;
    }

    public void save() throws SQLException, IOException {
        if (strategy == null) {
            throw new IllegalStateException("Chưa cấu hình chiến lược lưu trữ cho Note.");
        }
        strategy.save(this);
    }

    public void save(NoteStrategy strategy) throws SQLException, IOException {
        setStrategy(strategy);
        save();
    }

    public boolean delete(int noteId) throws SQLException, IOException {
        if (strategy == null) {
            throw new IllegalStateException("Chưa cấu hình chiến lược lưu trữ cho Note.");
        }
        return strategy.delete(noteId);
    }

    public boolean delete(int noteId, NoteStrategy strategy) throws SQLException, IOException {
        setStrategy(strategy);
        return delete(noteId);
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title == null ? "" : title.trim();
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content == null ? "" : content;
    }

    public int getTypeId() {
        return typeId;
    }

    public void setTypeId(int typeId) {
        this.typeId = typeId;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }
}