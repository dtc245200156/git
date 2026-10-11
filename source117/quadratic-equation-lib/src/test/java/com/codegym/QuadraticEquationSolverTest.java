package com.codegym;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class QuadraticEquationSolverTest {

    @Test
    void returnsTwoRealRoots() {
        QuadraticEquationSolver.Solution result =
                QuadraticEquationSolver.solve(1, -3, 2);

        assertEquals(QuadraticEquationSolver.Type.TWO_REAL_ROOTS, result.getType());
        assertEquals(2, result.getRoots().size());
        assertEquals(1.0, result.getRoots().get(0), 1.0e-9);
        assertEquals(2.0, result.getRoots().get(1), 1.0e-9);
    }

    @Test
    void returnsOneRealRootWhenDiscriminantIsZero() {
        QuadraticEquationSolver.Solution result =
                QuadraticEquationSolver.solve(1, 2, 1);

        assertEquals(QuadraticEquationSolver.Type.ONE_REAL_ROOT, result.getType());
        assertEquals(-1.0, result.getRoots().get(0), 1.0e-9);
    }

    @Test
    void returnsNoRealRootsWhenDiscriminantIsNegative() {
        QuadraticEquationSolver.Solution result =
                QuadraticEquationSolver.solve(1, 0, 1);

        assertEquals(QuadraticEquationSolver.Type.NO_REAL_ROOTS, result.getType());
        assertTrue(result.getRoots().isEmpty());
    }

    @Test
    void solvesLinearEquationWhenQuadraticCoefficientIsZero() {
        QuadraticEquationSolver.Solution result =
                QuadraticEquationSolver.solve(0, 2, -4);

        assertEquals(QuadraticEquationSolver.Type.LINEAR_EQUATION, result.getType());
        assertEquals(2.0, result.getRoots().get(0), 1.0e-9);
    }

    @Test
    void detectsNoSolution() {
        QuadraticEquationSolver.Solution result =
                QuadraticEquationSolver.solve(0, 0, 3);

        assertEquals(QuadraticEquationSolver.Type.NO_SOLUTION, result.getType());
        assertTrue(result.getRoots().isEmpty());
    }

    @Test
    void detectsInfiniteSolutions() {
        QuadraticEquationSolver.Solution result =
                QuadraticEquationSolver.solve(0, 0, 0);

        assertEquals(QuadraticEquationSolver.Type.INFINITE_SOLUTIONS, result.getType());
        assertTrue(result.getRoots().isEmpty());
    }

    @Test
    void rejectsNonFiniteCoefficients() {
        assertThrows(IllegalArgumentException.class,
                () -> QuadraticEquationSolver.solve(Double.NaN, 1, 1));
    }
}