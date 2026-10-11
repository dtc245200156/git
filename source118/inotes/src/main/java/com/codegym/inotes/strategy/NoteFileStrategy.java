package com.codegym.inotes.strategy;

import com.codegym.inotes.model.Note;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardOpenOption;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Locale;

/**
 * Pipe-delimited UTF-8 file strategy. Fields escape backslashes, pipes and
 * line breaks so that a note stays on one physical line:
 * id|title|content|typeId
 */
public class NoteFileStrategy implements NoteStrategy {
    private static final String DEFAULT_FILE = "data/notes.txt";
    private final Path filePath;

    public NoteFileStrategy() {
        this(Path.of(System.getProperty("inotes.file.path", DEFAULT_FILE)));
    }

    public NoteFileStrategy(Path filePath) {
        this.filePath = filePath.toAbsolutePath().normalize();
    }

    private void ensureFile() throws IOException {
        Path parent = filePath.getParent();
        if (parent != null) {
            Files.createDirectories(parent);
        }
        if (Files.notExists(filePath)) {
            Files.createFile(filePath);
        }
    }

    @Override
    public synchronized void save(Note note) throws IOException {
        List<Note> notes = findAll();
        if (note.getId() <= 0) {
            int nextId = notes.stream().mapToInt(Note::getId).max().orElse(0) + 1;
            note.setId(nextId);
            notes.add(note);
        } else {
            boolean replaced = false;
            for (int i = 0; i < notes.size(); i++) {
                if (notes.get(i).getId() == note.getId()) {
                    notes.set(i, note);
                    replaced = true;
                    break;
                }
            }
            if (!replaced) {
                throw new IOException("Không tìm thấy ghi chú có ID " + note.getId());
            }
        }
        writeAll(notes);
    }

    @Override
    public synchronized boolean delete(int id) throws IOException {
        List<Note> notes = findAll();
        boolean removed = notes.removeIf(note -> note.getId() == id);
        if (removed) {
            writeAll(notes);
        }
        return removed;
    }

    @Override
    public synchronized List<Note> findAll() throws IOException {
        ensureFile();
        List<Note> notes = new ArrayList<>();
        for (String line : Files.readAllLines(filePath, StandardCharsets.UTF_8)) {
            if (line.isBlank()) {
                continue;
            }
            List<String> fields = parseLine(line);
            if (fields.size() != 4) {
                throw new IOException("Dòng ghi chú không hợp lệ trong " + filePath);
            }
            try {
                Note note = new Note(
                        Integer.parseInt(fields.get(0)),
                        fields.get(1),
                        fields.get(2),
                        Integer.parseInt(fields.get(3)));
                notes.add(note);
            } catch (NumberFormatException exception) {
                throw new IOException("ID hoặc typeId không hợp lệ trong file ghi chú.", exception);
            }
        }
        notes.sort(Comparator.comparingInt(Note::getId).reversed());
        return notes;
    }

    @Override
    public synchronized List<Note> search(String keyword) throws IOException {
        String term = keyword == null ? "" : keyword.trim().toLowerCase(Locale.ROOT);
        if (term.isEmpty()) {
            return findAll();
        }
        return findAll().stream()
                .filter(note -> note.getTitle().toLowerCase(Locale.ROOT).contains(term)
                        || note.getContent().toLowerCase(Locale.ROOT).contains(term))
                .toList();
    }

    @Override
    public synchronized Note findById(int id) throws IOException {
        return findAll().stream().filter(note -> note.getId() == id).findFirst().orElse(null);
    }

    private void writeAll(List<Note> notes) throws IOException {
        ensureFile();
        List<String> lines = notes.stream()
                .sorted(Comparator.comparingInt(Note::getId))
                .map(note -> note.getId() + "|" + escape(note.getTitle()) + "|"
                        + escape(note.getContent()) + "|" + note.getTypeId())
                .toList();
        Files.write(filePath, lines, StandardCharsets.UTF_8,
                StandardOpenOption.TRUNCATE_EXISTING, StandardOpenOption.WRITE);
    }

    private String escape(String value) {
        return value.replace("\\", "\\\\")
                .replace("|", "\\|")
                .replace("\r", "\\r")
                .replace("\n", "\\n");
    }

    /**
     * Parse delimiters while honoring escaped pipes, backslashes and line breaks.
     */
    private List<String> parseLine(String line) {
        List<String> fields = new ArrayList<>();
        StringBuilder current = new StringBuilder();
        boolean escaped = false;
        for (int i = 0; i < line.length(); i++) {
            char ch = line.charAt(i);
            if (escaped) {
                switch (ch) {
                    case 'n' -> current.append('\n');
                    case 'r' -> current.append('\r');
                    default -> current.append(ch);
                }
                escaped = false;
            } else if (ch == '\\') {
                escaped = true;
            } else if (ch == '|') {
                fields.add(current.toString());
                current.setLength(0);
            } else {
                current.append(ch);
            }
        }
        if (escaped) {
            current.append('\\');
        }
        fields.add(current.toString());
        return fields;
    }

    @Override
    public String getName() {
        return "file";
    }
}