# дополнение к классу Avatar
class Avatar:
    # ... предыдущий код ...
    def __init__(self):
        # ...
        self.flying = False
        self.aura_radius = 130
        self.kill_particles = []

    def toggle_flight(self):
        self.flying = not self.flying

    def add_kill_particle(self):
        if self.flying:
            for _ in range(5):
                angle = random.uniform(0, 2*math.pi)
                speed = random.uniform(1, 4)
                self.kill_particles.append({
                    'x': self.x, 'y': self.y,
                    'vx': speed * math.cos(angle),
                    'vy': speed * math.sin(angle),
                    'life': 60
                })

    def draw_aura(self, surf):
        if self.flying:
            alpha = 80 + 40 * math.sin(self.pulse * 2)
            s = pygame.Surface((W, H), pygame.SRCALPHA)
            pygame.draw.circle(s, (255, 50, 50, alpha), (self.x, self.y), self.aura_radius, 4)
            pygame.draw.circle(s, (255, 0, 0, alpha//2), (self.x, self.y), self.aura_radius - 20, 2)
            surf.blit(s, (0, 0))
            # партиклы
            for p in self.kill_particles[:]:
                pygame.draw.circle(surf, (255, 100, 100, 150), (int(p['x']), int(p['y'])), 4)
                p['x'] += p['vx']
                p['y'] += p['vy']
                p['life'] -= 1
                if p['life'] <= 0:
                    self.kill_particles.remove(p)

    def update(self, dx=0, dy=0):
        self.x += dx * (2 if self.flying else 1)
        self.y += dy * (2 if self.flying else 1)
        self.angle += 0.01
        if self.flying and random.random() < 0.3:
            self.add_kill_particle()
