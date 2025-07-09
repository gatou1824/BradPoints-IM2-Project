import jwt from 'jsonwebtoken';

export function verifyToken(req, res, next) {
    const authHeader = req.headers.authorization;

    if (!authHeader || !authHeader.startsWith('Bearer ')) {
        return res.status(401).send({ message: 'No token provided' });
    }

    const token = authHeader.split(' ')[1];

    try {
        const decoded = jwt.verify(token, process.env.JWT_SECRET);
        req.user = {
            id: decoded.id,
            role: decoded.role
        }
        next(); // Allow the request to proceed
    } catch (err) {
        return res.status(403).send({ message: 'Invalid token' });
    }
}
