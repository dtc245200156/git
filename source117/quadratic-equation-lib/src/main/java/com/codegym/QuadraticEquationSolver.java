package com.codegym;

import java.util.List;
import java.util.Objects;

/**
 * Utility library that solves quadratic equations of the form
 * ax^2 + bx + c = 0.
 *
 * The class also handles degenerate equations where a = 0.
 */
public final class QuadraticEquationSolver {
    private static final double EPSILON = 1.0e-12;

    private QuadraticEquationSolver() {
        // Utility class; use the static solve method.
    }

    /**
     * Solves ax^2 + bx + c = 0 over the real numbers.
     *
     * @throws IllegalArgumentException if a coefficient is NaN or infinite
     */
    public static Solution solve(double a, double b, double c) {
        if (!Double.isFinite(a) || !Double.isFinite(b) || !Double.isFinite(c)) {
            throw new IllegalArgumentException("Coefficients must be finite numbers.");
        }

        if (isZero(a)) {
            if (!isZero(b)) {
                return new Solution(Type.LINEAR_EQUATION, List.of(-c / b), Double.NaN);
            }
            if (isZero(c)) {
                return new Solution(Type.INFINITE_SOLUTIONS, List.of(), Double.NaN);
            }
            return new Solution(Type.NO_SOLUTION, List.of(), Double.NaN);
        }

        double discriminant = b * b - 4.0 * a * c;
        if (discriminant < -EPSILON) {
            return new Solution(Type.NO_REAL_ROOTS, List.of(), discriminant);
        }

        if (Math.abs(discriminant) <= EPSILON) {
            double root = -b / (2.0 * a);
            return new Solution(Type.ONE_REAL_ROOT, List.of(root), discriminant);
        }

        // Use the stable q-form to reduce cancellation for roots of very
        // different magnitudes.
        double sqrtDiscriminant = Math.sqrt(discriminant);
        double q = -0.5 * (b + Math.copySign(sqrtDiscriminant, b));
        double x1 = q / a;
        double x2 = c / q;
        if (x1 > x2) {
            double temporary = x1;
            x1 = x2;
            x2 = temporary;
        }

        return new Solution(Type.TWO_REAL_ROOTS, List.of(x1, x2), discriminant);
    }

    private static boolean isZero(double value) {
        return Math.abs(value) <= EPSILON;
    }

    public enum Type {
        TWO_REAL_ROOTS,
        ONE_REAL_ROOT,
        NO_REAL_ROOTS,
        LINEAR_EQUATION,
        NO_SOLUTION,
        INFINITE_SOLUTIONS
    }

    /**
     * Immutable result returned by {@link #solve(double, double, double)}.
     * For a quadratic equation, discriminant contains b^2 - 4ac.
     * For degenerate equations it is NaN.
     */
    public static final class Solution {
        private final Type type;
        private final List<Double> roots;
        private final double discriminant;

        private Solution(Type type, List<Double> roots, double discriminant) {
            this.type = Objects.requireNonNull(type, "type");
            this.roots = List.copyOf(roots);
            this.discriminant = discriminant;
        }

        public Type getType() {
            return type;
        }

        /**
         * Returns real roots in ascending order. The list is immutable.
         * It is empty when there is no single finite answer or no real root.
         */
        public List<Double> getRoots() {
            return roots;
        }

        /**
         * Returns b^2 - 4ac for a quadratic equation, otherwise NaN.
         */
        public double getDiscriminant() {
            return discriminant;
        }

        @Override
        public String toString() {
            return "Solution{type=" + type
                    + ", roots=" + roots
                    + ", discriminant=" + discriminant + '}';
        }
    }
}