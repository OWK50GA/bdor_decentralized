import CandidatesList from "@/components/pages/candidates/CandidatesList";
import HeroSection from "@/components/pages/home/HeroSection";
import Image from "next/image";

export default function Home() {
  return (
    <div>
      <div className="w-fit mx-auto my-10">
        <HeroSection />
      </div>
      <div className="mt-20">
        <CandidatesList />
      </div>
    </div>
  );
}
